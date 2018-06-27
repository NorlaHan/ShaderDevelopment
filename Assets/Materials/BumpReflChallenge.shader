Shader "Holistic/BumpReflChallenge" {
	Properties {
//		// Albedo
//		_myDiffuseTint ("Diffuse Tint", Color) = (1,1,1,1)
//		_myDiffuseTex ("Diffuse Map", 2D) = "white" {}
		// Normal
		_myNormalTex ("Normal Map", 2D) = "bump" {}
		_myNormalSlider ("Normal Slider", Range(-10,10)) = 1
		// Albedo
		_myCubeTint ("Cube Tint", Color) = (1,1,1,1)
		_myCubeTex ("Cube Map" , CUBE) = "black" {}
		_myCubeSlider ("Cube Slider", Range(-10, 10)) = 1
	}
	SubShader {

//		Tags { "Queue" = "Geometry+100" }
//		ZWrite Off
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert
//			fixed4 _myDiffuseTint;
//			sampler2D _myDiffuseTex;

			sampler2D _myNormalTex;
			half _myNormalSlider;

			fixed4 _myCubeTint;
			samplerCUBE _myCubeTex;
			half _myCubeSlider;

		struct Input {
			float2 uv_myDiffuseTex;
			float2 uv_myNormalTex;
			float3 worldRefl; INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o) {
			//o.Albedo = (tex2D (_myDiffuseTex, IN.uv_myDiffuseTex) * _myDiffuseTint).rgb;
			o.Normal = UnpackNormal (tex2D (_myNormalTex, IN.uv_myNormalTex)) * float3 (_myNormalSlider,_myNormalSlider,1);
			o.Albedo = (texCUBE (_myCubeTex, WorldReflectionVector(IN, o.Normal)) * _myCubeSlider * _myCubeTint ).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
