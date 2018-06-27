Shader "Holistic/MyRim" {
	Properties {
		[Toggle(USE_TEXTURE)] _useDiffuse ("Use Diffuse?", float) = 0
		[Toggle(USE_NORMAL)] _useNormal ("Use Normal?", float) = 0

		_DiffuseTint ("Diffuse Tint", Color) = (1,1,1,1)
		_DiffuseTex ("Diffuse Texture", 2D) = ""{}
		_NormalTex ("Normal Texture", 2D) = ""{}
		
		_RimColor ("Rim Color", Color) = (0,0.5,0.5,0.0)
		_RimPower ("Rim Power", Range(0,10)) = 3
		_RimCutOff1 ("Rim CutOff1", Range (0,1)) = 0
		_RimCutOff2 ("Rim CutOff2", Range (0,1)) = 0

		_StripeDensity ("Stripe Density", float) = 10
		_StripeTensity ("Stripe Tensity", Range(0,1)) = 0.5

		_RimColor1 ("Rim Color 1", Color) = (0.85, 0.85, 0.85)
		_RimColor2 ("Rim Color 2", Color) = (0.5, 0.5, 0.5)
		_RimColor3 ("Rim Color 3", Color) = (0.1, 0.1, 0.1)
	}
	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert
			#pragma shader_feature USE_TEXTURE
			#pragma shader_feature USE_NORMAL

//			float _useDiffuse;
//			float _useNormal;


			fixed4 _DiffuseTint;
			sampler2D _DiffuseTex;
			sampler2D _NormalTex;

			float4 _RimColor;
			float _RimPower;
			float _RimCutOff1;
			float _RimCutOff2;
			float _StripeDensity;
			float _StripeTensity;
			half4 _RimColor1;
			half4 _RimColor2;
			half4 _RimColor3;

			struct Input {
				float2 uv_DiffuseTex;
				float2 uv_NormalTex;
				float3 worldRefl;

				float3 viewDir;
				float3 worldPos;
			};



			void surf (Input IN, inout SurfaceOutput o) {
				#ifdef USE_TEXTURE
					o.Albedo = (tex2D(_DiffuseTex, IN.uv_DiffuseTex )*_DiffuseTint);
				#else
					o.Albedo = _DiffuseTint;
				#endif

				#ifdef USE_NORMAL
					o.Normal = tex2D (_NormalTex, IN.uv_NormalTex);
				#endif

				half rim = pow(saturate(dot(normalize(IN.viewDir), o.Normal)),_RimPower);
				half rim2 = _RimColor.rgb * rim > _RimCutOff1 ? _RimColor1.rgb : rim >_RimCutOff2 ? _RimColor2.rgb : _RimColor3.rgb;
				//o.Emission = _RimColor.rgb * rim > _RimCutOff1 ? _RimColor1.rgb : rim >_RimCutOff2 ? _RimColor2.rgb : _RimColor3.rgb;
				//o.Emission = IN.worldPos.y >1 ? float3 (0,1,0) : _RimColor.rgb;
				o.Emission = (frac(IN.worldPos.y*_StripeDensity) > _StripeTensity ? _RimColor1.rgb : _RimColor2.rgb )* rim2;
			}

		ENDCG
	}
	FallBack "Diffuse"
}
