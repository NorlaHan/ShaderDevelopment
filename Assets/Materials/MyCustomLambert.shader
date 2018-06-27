Shader "Holistic/MyCustomLambert" {
	Properties {
		_Colour ("Color", Color) = (1,1,1,1)
//		_SpecColor ("Specular Color", Color) = (1,1,1,1)
//		_Spec ("Specular", Range(0,1)) = 0.5
//		_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {
		Tags{"Queue" = "Geometry"}
		
		CGPROGRAM

			#pragma surface surf BasicLambert

			half4 LightingBasicLambert (SurfaceOutput s, half3 lightDir, half atten){
				half NdotL = dot (s.Normal, lightDir);
				half4 c;
				c.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten);
				c.a = s.Alpha;
				return c;
			}

			float4 _Colour;
			//float4 _SpecColor;

//			half _Spec;
//			fixed _Gloss;

			struct Input {
				float2 uv_MainTex;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = _Colour.rgb;
//				o.Specular = _Spec;
//				o.Gloss = _Gloss;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
