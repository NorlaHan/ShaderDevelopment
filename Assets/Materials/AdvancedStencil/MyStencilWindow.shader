Shader "Holistic/MyStencilWindow" {
	Properties {
		_Colour ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}

		_SRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]	_SComp("Stencil Comp", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]	_SOp("Stencil Op", Float) = 2

//		_SpecColor ("Specular Color", Color) = (1,1,1,1)
//		_Spec ("Specular", Range(0,1)) = 0.5
//		_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {
		Tags{"Queue" = "Geometry-1"}

		ZWrite off
		ColorMask 0

		Stencil {
			Ref [_SRef]
			Comp [_SComp]
			Pass [_SOp]
		}

		CGPROGRAM

			#pragma surface surf Lambert

			float4 _Colour;
			sampler2D _MainTex;


//			half _Spec;
//			fixed _Gloss;

			struct Input {
				float2 uv_MainTex;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;

			}
		ENDCG
	}
	FallBack "Diffuse"
}