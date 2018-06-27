Shader "Holistic/MyStandardSpecularPBR" {
	Properties {

		_Color ("Color", Color) = (1,1,1,1)
		_MetallicTex ("Metallic (R)", 2D) = "white" {}

		_Metallic ("Metallic", Range (0.0,1.0)) = 0.0
		_SpecColor ("Specular Color", Color ) = (1,1,1,1)

		_EmiSlider ("Emission Slider", Range (0,5)) = 0
	}
	SubShader {
		Tags { "RenderType"="Geometry" }
		 

		CGPROGRAM

			#pragma surface surf StandardSpecular
			fixed4 _Color;
			sampler2D _MetallicTex;

			half _Metallic;

			half _EmiSlider;

			struct Input {
				float2 uv_MetallicTex;
			};


			void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
				o.Albedo = _Color;
				o.Smoothness = 1-tex2D (_MetallicTex, IN.uv_MetallicTex).g;
				o.Emission = ( tex2D (_MetallicTex, IN.uv_MetallicTex).g) * _EmiSlider;
				o.Specular = _SpecColor.rgb;
			}

		ENDCG
	}
	FallBack "Diffuse"
}
