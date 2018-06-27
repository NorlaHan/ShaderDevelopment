Shader "Holistic/AllProps"{
	Properties {
		// Properties order matters.

		_myColor ("Aldedo Tint", Color) = (1,1,1,1)
		_myTex ("Aldedo Texture" , 2D) = "white" {}
		_myRange ("Aldedo Range" , Range(0,5)) = 1

		_myColor2 ("Reflection Tint", Color) = (1,1,1,1)
		_myCube ("Reflection CubeMap", CUBE) = "" {}
		_myRange2 ("Reflection Range2", range (0,5)) = 1


		_myFloat ("Example Float", Float) = 0.5
		_myVector ("Example Vector", Vector) = (0.5,1,1,1)
	}
	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			fixed4 _myColor;
			sampler2D _myTex;
			half _myRange;

			fixed4 _myColor2;
			samplerCUBE _myCube;
			half _myRange2;

			float _myFloat;
			float4 _myVector;

			struct Input {
				float2 uv_myTex;
				float3 worldRefl;
			};

			void surf (Input IN, inout SurfaceOutput o){
				o.Albedo = (tex2D(_myTex, IN.uv_myTex)  *_myColor).rgb;
				o.Albedo.g = 1;
				fixed3 bb = o.Albedo;
				o.Albedo = bb * _myRange;

				o.Emission = (texCUBE (_myCube, IN.worldRefl) * _myRange2 * _myColor2).rgb;
			}

		ENDCG
	}
	Fallback "Diffuse"
}