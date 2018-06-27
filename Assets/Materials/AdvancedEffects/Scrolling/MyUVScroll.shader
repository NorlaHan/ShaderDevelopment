Shader "Holistic/MyUVScroll" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_FoamTex ("Foam texture", 2D) = "white" {}
		_ScrollX ("Scroll X", Range(-5,5)) = 1
		_ScrollY ("Scroll Y", Range(-5,5)) = 1
		_ScrollFX ("Scroll X", Range(-5,5)) = 1
		_ScrollFY ("Scroll Y", Range(-5,5)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		
		CGPROGRAM

		#pragma surface surf Lambert


		sampler2D _MainTex;
		sampler2D _FoamTex;
		float _ScrollX;
		float _ScrollY;
		float _ScrollFX;
		float _ScrollFY;

		struct Input {
			float2 uv_MainTex;
			float2 uv_FoamTex;
		};


		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o) {
			_ScrollX *= _Time;
			_ScrollY *= _Time;
			_ScrollFX *= _Time;
			_ScrollFY *= _Time;
			float2 newuv = IN.uv_MainTex + float2 (_ScrollX,_ScrollY);
			float2 newuvF = IN.uv_FoamTex + float2 (_ScrollFX,_ScrollFY);
			fixed4 c = (tex2D (_MainTex, newuv)+ tex2D (_FoamTex, newuvF))*0.5 * _Color;
			o.Albedo = c.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
