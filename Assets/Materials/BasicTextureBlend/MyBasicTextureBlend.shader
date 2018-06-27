Shader "Holistic/MyBasicTextureBlend" {
	Properties {
		_DiffuseTint ("Diffuse Tint", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}

		_DecalTex ("Decal Texture", 2D) = "white" {}
		[Toggle] _ShowDecal ("Show Decal", Float) = 0
//		_SpecColor ("Specular Color", Color) = (1,1,1,1)
//		_Spec ("Specular", Range(0,1)) = 0.5
//		_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {
		Tags{"Queue" = "Geometry"}


		
		CGPROGRAM

			#pragma surface surf Lambert

			sampler2D _MainTex ;
			sampler2D _DecalTex;

			float4 _DiffuseTint;
			float  _ShowDecal;
			//float4 _SpecColor;

//			half _Spec;
//			fixed _Gloss;

			struct Input {
				float2 uv_MainTex;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				fixed4 a = tex2D (_MainTex, IN.uv_MainTex) ;
				fixed4 b = (tex2D (_DecalTex, IN.uv_MainTex) * 0.5 + 0.5 )*_ShowDecal;
				//o.Albedo = (a.rgb + b.rgb) * _DiffuseTint;
				o.Albedo = b.r > 0.9 ? b.rgb: a.rgb;

//				o.Albedo = _DiffuseTint.rgb;
//				o.Specular = _Spec;
//				o.Gloss = _Gloss;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
