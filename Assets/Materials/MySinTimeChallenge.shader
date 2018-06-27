Shader "Holistic/MySinTimeChallenge" {
	Properties {
		_Colour ("Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (1,1,1,1)
		_Spec ("Specular", Range(0,1)) = 0.5
		_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {
		Tags{"Queue" = "Geometry"}
		
		CGPROGRAM

			#pragma surface surf BasicBlinn

			float4 LightingBasicBlinn (SurfaceOutput s, half3 lightDir, half3 viewDir, half atten){
			half3 h = normalize (lightDir + viewDir);
			half diff = max (0, dot (s.Normal, lightDir));
			float nh = max (0, dot(s.Normal, h));
			float spec = pow (nh , 48.0);

			half4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * diff + _LightColor0.rgb * spec) * atten * _SinTime;
			c.a = s.Alpha;
			return c;
			}

			float4 _Colour;
			//float4 _SpecColor;

			half _Spec;
			fixed _Gloss;

			struct Input {
				float2 uv_MainTex;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = _Colour.rgb;
				o.Specular = _Spec;
				o.Gloss = _Gloss;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
