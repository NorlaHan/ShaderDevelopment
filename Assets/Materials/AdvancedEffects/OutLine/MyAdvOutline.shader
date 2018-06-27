Shader "Holistic/MyAdvOutline" {
	Properties {
		_DiffuseTint ("Diffuse Tint", Color) = (1,1,1,1)
		_MainTex ("Texture" , 2D) = "white" {}
		_OutlineColor ("Outline Color", Color) = (0,0,0,1)
		_Outline ("OutLineWidth", Range(-1,1)) = 0.005
		//_Gloss ("Gloss", Range(0,1)) = 0.5
	}
	SubShader {

		ZWrite On
		CGPROGRAM

			#pragma surface surf Lambert

			struct Input {
				float2 uv_MainTex;
			};

			half4 _DiffuseTint;
			sampler2D _MainTex;

			void surf (Input IN, inout SurfaceOutput o) {
				o.Albedo = (tex2D (_MainTex, IN.uv_MainTex) * _DiffuseTint).rgb;

			}
		ENDCG

		Pass {				// B/c it's a vertex fragment
			Cull Front

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
			};			

			float _Outline;
			float4 _OutlineColor;

			v2f vert(appdata v) {
				v2f o = (v2f)0;
				o.pos = UnityObjectToClipPos(v.vertex);		// Require in vertex shader

				float3 norm = normalize (mul ((float3x3)UNITY_MATRIX_IT_MV, v.normal)); // mul = multiply, convert normal of the vertex into world space.
				float2 offset = TransformViewToProjection(norm.xy);		// "#include "UnityCG.cginc""

				o.pos.xy += offset * o.pos.z * _Outline;
				o.color = _OutlineColor;
				return o;
			}

			fixed4 frag (v2f i) : SV_Target {
				return i.color;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
