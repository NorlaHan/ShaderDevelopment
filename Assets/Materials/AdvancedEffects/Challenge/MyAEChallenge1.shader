Shader "Holistic/MyAEChallenge1" {
	Properties {
		_Tint ("Diffuse tint", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_FoamTex ("Foam texture", 2D) = "white" {}

		// UV Scrolling
		_ScrollX ("Scroll X", Range(-5,5)) = 1
		_ScrollY ("Scroll Y", Range(-5,5)) = 1
		_ScrollFX ("Scroll Foam X", Range(-5,5)) = 1
		_ScrollFY ("Scroll Foam Y", Range(-5,5)) = 1


		// Vertices Waves
		_Freq ("Frequency", Range(0,5)) = 3
		_Freq2 ("Frequency2", Range(0,10)) = 0
		_Speed ("Speed", Range(0,100)) = 10
		_Amp ("Amplitude", Range(0,1)) = 0.5
		_VertColorAdj("Vertex color adjustment", float) = 2


	}
	SubShader {
		CGPROGRAM

		#pragma surface surf Lambert vertex:vert

		float4 _Tint;
		sampler2D _MainTex;
		sampler2D _FoamTex;

		float _ScrollX;
		float _ScrollY;
		float _ScrollFX;
		float _ScrollFY;

		float _Freq;
		float _Freq2;
		float _Speed;
		float _Amp;
		float _VertColorAdj;

		struct appdata {
			float4 vertex : POSITION;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
		};

		struct Input {
			float2 uv_MainTex;
			float2 uv_FoamTex;
			float3 vertColor;
		};

		void vert (inout appdata v, out Input o){
			UNITY_INITIALIZE_OUTPUT(Input,o);
			float t = _Time * _Speed;
			float waveHeightX = (sin ((t+ v.vertex.x)* _Freq)+ sin ((t+ v.vertex.x) * _Freq2) ) * _Amp;		//+ sin (t+ v.vertex.x * _Freq) )
			float waveHeightZ = (cos ((t+ v.vertex.z)* _Freq) + cos ((t+ v.vertex.z)* _Freq2) ) * _Amp;

			v.vertex.y = v.vertex.y + waveHeightX + waveHeightZ;

			v.normal = normalize (float3(v.normal.x + waveHeightX, v.normal.y + waveHeightZ, v.normal.z));
			o.vertColor = (waveHeightX + waveHeightZ)*0.5 + _VertColorAdj;
		}


		void surf (Input IN, inout SurfaceOutput o) {
			_ScrollX *= _Time;
			_ScrollY *= _Time;
			_ScrollFX *= _Time;
			_ScrollFY *= _Time; 

			float2 newuv = IN.uv_MainTex + float2 (_ScrollX, _ScrollY);
			float2 newuvF = IN.uv_FoamTex + float2 (_ScrollFX, _ScrollFY);
			// Albedo comes from a texture tinted by color
			fixed4 c = (tex2D (_MainTex, newuv) + tex2D (_FoamTex, newuvF))*0.5 * _Tint;
			o.Albedo = c * IN.vertColor.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
