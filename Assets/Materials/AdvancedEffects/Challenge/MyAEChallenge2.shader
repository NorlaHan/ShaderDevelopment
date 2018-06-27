Shader "Holistic/MyAEChallenge2" {
	Properties {
		_Tint ("Tint", Color) = (1,1,1,1)
		_Speed ("Speed", Range(1,100)) = 10
		_Scale1 ("Scale 1", Range(0.1,10)) = 2
		_Scale2 ("Scale 2", Range(0.1,10)) = 2
		_Scale3 ("Scale 3", Range(0.1,10)) = 2
		_Scale4 ("Scale 4", Range(0.1,10)) = 2
//		_MainTex ("Albedo (RGB)", 2D) = "white" {}

	}
	SubShader {
		Tags { "RenderType"="Opaque" }

		Pass{	
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
			};

			struct v2f {
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
			};

			fixed4 _Tint;
			float _Speed;
			float _Scale1;
			float _Scale2;
			float _Scale3;
			float _Scale4;


			v2f vert (appdata v) {
				v2f o = (v2f)0;

				o.vertex = UnityObjectToClipPos(v.vertex);

				const float PI = 3.14159265;
				float t = _Time * _Speed;

				// Vertical
				float c = sin (v.vertex.x * _Scale1 + t);

				// Horizontal
				c += sin (v.vertex.z * _Scale2 + t);

				// Diagonal
				c += sin (_Scale3 * (v.vertex.x * sin(t/2.0) + v.vertex.z * cos (t/3.0)) + t);

				// Circular
				float c1 = pow (v.vertex.x + 0.5 * sin (t/5), 2);
				float c2 = pow (v.vertex.z + 0.5 * cos (t/3), 2);

				c+= sin (sqrt(_Scale4 * (c1+ c2) + 1 + t) );

				o.color.r = sin (c/4.0 * PI);
				o.color.g = sin (c/4.0 * PI + 2* PI/4);
				o.color.b = sin (c/4.0 * PI + 4* PI/4);
				o.color *= _Tint;

				return o;
			}

			fixed4 frag (v2f i) : SV_Target {
				fixed4 col = i.color;

				return col;
			}
			ENDCG
		}
	}
}
