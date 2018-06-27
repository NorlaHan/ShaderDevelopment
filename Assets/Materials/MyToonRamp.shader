Shader "Holistic/MyToonRamp" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_RampTex ("Ramp Texture", 2D) = "white" {}
		_NormalTex ("Normal Tex", 2D) = "" {}
		_diffSliderM ("Diffuse Multiply", range (-10,10)) = 0.5
		_diffSliderP ("Diffuse Plus", Range (0,1)) = 0.5
	}

	SubShader {
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
			#pragma surface surf Lambert//ToonRamp

			float4 _Color;
			sampler2D _RampTex;
			sampler2D _NormalTex;

			half _diffSliderM;
			half _diffSliderP;

			float4 LightingToonRamp (SurfaceOutput s, fixed3 lightDir, fixed atten){
				float diff = dot (s.Normal, lightDir);
				float h = diff * 0.5 + 0.5;
				float2 rh = h;
				float3 ramp = tex2D(_RampTex, rh).rgb;

				float4 c;
				c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
				c.a = s.Alpha;
				return c;
			}
			


			struct Input {
				float2 uv_RampTex;
				float3 viewDir;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				float diff = dot (o.Normal, IN.viewDir);
				float h = diff*_diffSliderM + _diffSliderP;
				float2 rh = h;
				o.Albedo = tex2D(_RampTex, rh).rgb;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
