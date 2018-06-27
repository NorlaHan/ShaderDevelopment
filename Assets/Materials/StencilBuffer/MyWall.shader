Shader "Holistic/MyWall" {
	Properties {
		_Colour ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}

//		_SpecColor ("Specular Color", Color) = (1,1,1,1)
//		_Spec ("Specular", Range(0,1)) = 0.5
//		_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {
		Tags{"Queue" = "Geometry"}

		Stencil {
			Ref 1 
			Comp notequal
			Pass keep
		}
		
		CGPROGRAM

			#pragma surface surf Lambert

			float4 _Colour;
			sampler2D _MainTex;
			//float4 _SpecColor;
//
//			half _Spec;
//			fixed _Gloss;

			struct Input {
				float2 uv_MainTex;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				fixed4 c = tex2D (_MainTex, IN.uv_MainTex);
				o.Albedo = (c * _Colour).rgb;
//				o.Specular = _Spec;
//				o.Gloss = _Gloss;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
