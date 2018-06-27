Shader "Holistic/NormalPlay" {
	Properties {
		_myX ("Nx", Range (-10,10)) = 1
		_myY ("Nx", Range (-10,10)) = 1
		_myZ ("Nx", Range (-10,10)) = 1
	}
	SubShader {

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
			#pragma surface surf Lambert

			half _myX;
			half _myY;
			half _myZ; 


		struct Input {
			float2 uv_myDiffuse;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			o.Albedo = 1;
			o.Normal = float3 (_myX,_myY, _myZ);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
