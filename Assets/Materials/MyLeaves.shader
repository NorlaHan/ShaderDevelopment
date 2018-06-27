Shader "Holistic/MyLeaves" {
	Properties {
		_AlbedoTint ("Albedo Tint", Color) = (1,1,1,1)
		_MainTex ("Main Texture", 2D) = "white" {}
//		_SpecColor ("Specular Color", Color) = (1,1,1,1)
//		_Spec ("Specular", Range(0,1)) = 0.5
//		_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {
		Tags{"Queue" = "Transparent"}
		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off
		Pass {
			SetTexture [_MainTex] { combine texture }
		}
		
//		CGPROGRAM
//
//			#pragma surface surf Lambert alpha:fade
//
//			float4 _AlbedoTint;
//			//float4 _SpecColor;
//			sampler2D _MainTex;

//			half _Spec;
//			fixed _Gloss;

//			struct Input {
//				float2 uv_MainTex;
//			};

//			void surf (Input IN, inout SurfaceOutput o) {
//			fixed4 c = ( tex2D(_MainTex, IN.uv_MainTex) * _AlbedoTint);
//				o.Albedo = c.rgb;
//				o.Alpha = c.a;
//				o.Specular = _Spec;
//				o.Gloss = _Gloss;
//			}
//		ENDCG
	}
//	FallBack "Diffuse"
}
