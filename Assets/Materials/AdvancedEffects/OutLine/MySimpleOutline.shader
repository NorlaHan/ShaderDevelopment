Shader "Holistic/MySimpleOutline" {
	Properties {
		_DiffuseTint ("Diffuse Tint", Color) = (1,1,1,1)
		_MainTex ("Texture" , 2D) = "white" {}
		_OutlineColor ("Outline Color", Color) = (0,0,0,1)
		_Outline ("OutLineWidth", Range(0,1)) = 0.005
		//_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {
		//Tags{"Queue" = "Geometry"}

		ZWrite Off

		CGPROGRAM
			#pragma surface surf Lambert vertex:vert
			struct Input {
				float2 uv_MainTex;
			};

			float _Outline;
			float4 _OutlineColor;


			void vert (inout appdata_full v) {
				v.vertex.xyz += v.normal * _Outline;
			}

			void surf (Input IN, inout SurfaceOutput o){
				o.Emission = _OutlineColor.rgb;
			}


		ENDCG

		ZWrite On
		CGPROGRAM

			#pragma surface surf Lambert

			struct Input {
				float2 uv_MainTex;
			};

			half4 _DiffuseTint;
			sampler2D _MainTex;

			void surf (Input IN, inout SurfaceOutput o) {
				//o.Emission = _OutlineColor.rgb;
				o.Albedo = (tex2D (_MainTex, IN.uv_MainTex) * _DiffuseTint).rgb;

			}
		ENDCG
	}
	FallBack "Diffuse"
}
