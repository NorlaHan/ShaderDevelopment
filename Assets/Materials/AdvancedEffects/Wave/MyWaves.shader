Shader "Holistic/MyWaves" {
	Properties {
		_Tint ("Diffuse tint", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Freq ("Frequency", Range(0,5)) = 3
		_Speed ("Speed", Range(0,100)) = 10
		_Amp ("Amplitude", Range(0,1)) = 0.5
		_VertColorAdj("Vertex color adjustment", float) = 2
	}
	SubShader {

		Cull off
		CGPROGRAM
		// A surface shader and a vertex shader.
		#pragma surface surf Lambert vertex:vert	


		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;	// Water color
			float3 vertColor;	// Add tint base on the vertices
		};

		float4 _Tint;
		float _Freq;
		float _Speed;
		float _Amp;
		float _VertColorAdj;

		struct appdata {
			float4 vertex: POSITION;
			float3 normal: NORMAL;
			float4 texcoord: TEXCOORD0;
			float4 texcoord1: TEXCOORD1;
			float4 texcoord2: TEXCOORD2;
		};

		void vert (inout appdata v, out Input o){	// Modify vertex color thus out Input struct.
			UNITY_INITIALIZE_OUTPUT(Input,o);
			float t = _Time * _Speed;		// _Time is a unity created variant.
			float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp + sin(t*2 + v.vertex.x * _Freq*2) * _Amp;
			float waveHeight2 = cos(t + v.vertex.x * _Freq) * _Amp + cos(t*3 + v.vertex.x * _Freq*2) * _Amp;

			v.vertex.y += waveHeight;
			// The vertices of the mesh had been modified, therefore normal needs to be updated.
			// Or wired shadow may occur.
			v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y + waveHeight2, v.normal.z));
			o.vertColor = waveHeight + _VertColorAdj;
		}


		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			float4 c = tex2D (_MainTex, IN.uv_MainTex) * _Tint;
			o.Albedo = c * IN.vertColor.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
