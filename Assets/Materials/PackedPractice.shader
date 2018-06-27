Shader "Holistic/PackedPractice" {
	Properties {
		_myColour ("Example Colour", Color) = (1,1,1,1)
	}
	SubShader {

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Lambert

			struct Input {
				float2 uvMainTex;
			};

			fixed4 _myColour;

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = _myColour.rgb;
			}
		ENDCG
	}
	FallBack "Diffuse"
}
