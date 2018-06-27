Shader "Holistic/MyBumpDiffuseStencil" {
	Properties {
		_Colour ("Color", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
		_Bump ("Bump Texyure", 2D) = "bump" {}
		_BumpSlider ("Bump Amount", Range(0,10)) = 1

		_SRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)]	_SCompare("Stencil Comp", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)]	_SOp("Stencil Op", Float) = 2

//		_SpecColor ("Specular Color", Color) = (1,1,1,1)
//		_Spec ("Specular", Range(0,1)) = 0.5
//		_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {
//		Tags{"Queue" = "Geometry-1"}
//
//		ZWrite on
//		ColorMask 0

		Stencil {
			Ref [_SRef]
			Comp [_SCompare]
			Pass [_SOp]
		}

		CGPROGRAM

			#pragma surface surf Lambert

			float4 _Colour;
			sampler2D _MainTex;
			sampler2D _Bump;
			half _BumpSlider;


//			half _Spec;
//			fixed _Gloss;

			struct Input {
				float2 uv_MainTex;
				float2 uv_Bump;
			};

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * _Colour.rgb;
				o.Normal = UnpackNormal (tex2D(_Bump, IN.uv_Bump));
				o.Normal *= float3 (_BumpSlider,_BumpSlider,1);
			}
		ENDCG
	}
	FallBack "Diffuse"
}