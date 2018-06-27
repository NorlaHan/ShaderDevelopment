Shader "Holistic/MyExtrude"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_ColorSlider ("Vertex Color Slider", Float) = 1
		_VertexSlider ("Vertex Normal Slider", Float) = 0.1
	}

	SubShader
	{
		Tags { "RenderType"="Opaque" }

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert
		#pragma  nolightmap nodirlightmap nodynlightmap  // novertexlight
		
		//#include "UnityCG.cginc"

		struct Input {
			float2 uv_MainTex;
		};

		struct appdata{
			float4 vertex: POSITION;
			float3 normal: NORMAL;
			float4 texcoord: TEXCOORD0;
		};

		sampler2D _MainTex;
		half _ColorSlider;
		half _VertexSlider;

		void vert (inout appdata v){
			v.vertex.xyz += v.normal * _VertexSlider;
		}

		void surf (Input IN, inout SurfaceOutput o){
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
		}
		ENDCG
	}
	Fallback "Diffuse"
}
