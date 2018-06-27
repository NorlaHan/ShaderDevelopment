Shader "Holistic/MyColourVF"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_CoorScaler ("Coordinate Scaler", Float) = 10
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass	// Need "Pass {} " when using Vertex and fragment toghther.
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 color: COLOR;
			};

			half _CoorScaler;

			// coordinate here is in world space.
			v2f vert (appdata v)			
			{
				v2f o;	// the "o" will pass as the "i" of "fixed4 frag (v2f i) : SV_Target"
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.color.r = (v.vertex.x +(_CoorScaler*0.5)) / _CoorScaler;
				o.color.g = (v.vertex.z +(_CoorScaler*0.5)) / _CoorScaler;

				return o;
			}

			// coordinate here is in screen space. Large data caculated. change when camera or object transformed.
			fixed4 frag (v2f i) : SV_Target
			{
				//fixed4 col = fixed4 (0,1,0,1);
				fixed4 col = i.color;
				//col.r = i.vertex.x/500;
				//col.g = i.vertex.y/500;

				return col;
			}
			ENDCG
		}
	}
}
