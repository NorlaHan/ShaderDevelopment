Shader "Holistic/MyDorProduct"
{
	Properties{
		_myDotSlider1 ("Dot Slider" , Range(-10,10)) = 1
		_myDotSlider2 ("Dot Slider" , Range(-10,10)) = 1
		_myDotSlider3 ("Dot Slider" , Range(-10,10)) = 1
	}
	SubShader{

		CGPROGRAM
			#pragma surface surf Lambert

			half _myDotSlider1;
			half _myDotSlider2;
			half _myDotSlider3;

			struct Input {
				float3 viewDir;
			};

			void surf (Input IN, inout SurfaceOutput o){
				half dotp = dot(IN.viewDir, o.Normal);
				o.Albedo = float3 (ceil(pow(dotp,_myDotSlider1)),_myDotSlider2,_myDotSlider3);
			}

		ENDCG

	}
	Fallback "Diffuse"
}
