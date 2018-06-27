Shader "Holistic/Challenge4"{
	Properties {
		// Properties order matters.

		_myDiffuseTint ("Diffuse Tint", Color) = (1,1,1,1)
		_myDiffuseTex ("Diffuse Texture" , 2D) = "white" {}
		_myDiffuseSlider ("Diffuse Slider", range(-10,10)) = 1

		_myEmissiveTint ("Emissive Tint", Vector) = (1,1,1,1)	// Use Vector b/c emissive can't use scalar. 
		_myEmissiveTex ("Emissive Texture" , 2D) = "black" {}
		_myEmissiveSlider ("Emissive Slider" , range (0,10)) = 1

		_myNormalTex ("Normal Texture", 2D) = "bump" {}
		_myNormalSlider ("Normal Amount", Range(0,10)) = 1
		_myNormalBrightSlider ("Normal Brightness", range (-10,10)) = 1

		_myCubeTex ("Cube Map", CUBE) = "white" {}
		_myCubeSlider ("CubeMap Slider", Range (-10,10)) = 1

		_myBumpTex ("Bump Texture", 2D) = "bump" {}

		//_mymissiveRange ("Emissive Range", range (0,5)) = 1

	}
	SubShader {

		CGPROGRAM
			#pragma surface surf Lambert

			fixed4 _myDiffuseTint;
			sampler2D _myDiffuseTex;
			half _myDiffuseSlider;

			fixed4 _myEmissiveTint;
			sampler2D _myEmissiveTex;
			half _myEmissiveSlider;

			//fixed _myEmissiveRange;	// Emissive can not be multiplied with scalar.
			sampler2D _myNormalTex;
			half _myNormalSlider;
			half _myNormalBrightSlider;

			samplerCUBE _myCubeTex;
			half _myCubeSlider;

			sampler2D _myBumpTex;

			struct Input {
				float2 uv_myDiffuseTex;
				float2 uv_myEmissiveTex; 
				float2 uv_myNormalTex; 
				float2 uv_myBumpTex;
				float3 worldRefl; INTERNAL_DATA
			};

			void surf (Input IN, inout SurfaceOutput o){
				o.Albedo = (tex2D(_myDiffuseTex, IN.uv_myDiffuseTex) * _myDiffuseTint).rgb;
				o.Albedo *= _myDiffuseSlider;

				o.Normal = UnpackNormal (tex2D (_myNormalTex, IN.uv_myNormalTex)) *_myNormalBrightSlider;
				o.Normal *= float3 (_myNormalSlider,_myNormalSlider,1);

//				o.Emission = (tex2D (_myEmissiveTex, IN.uv_myEmissiveTex) * _myEmissiveTint ).rgb;
//				o.Emission *= float3 (_myEmissiveSlider,_myEmissiveSlider,_myEmissiveSlider);

//				o.Emission = (texCUBE (_myCubeTex, WorldReflectionVector(IN, o.Normal) * _myCubeSlider)).rgb;



				
			}

		ENDCG
	}
	Fallback "Diffuse"
}