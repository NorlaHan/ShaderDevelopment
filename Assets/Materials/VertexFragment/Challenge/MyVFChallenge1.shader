Shader "Holistic/MyVFChallenge1"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_ColorSlider ("Vertex Color Slider", Float) = 1
		_ColorSliderB ("Vertex Color Slider Blue", Float) = 1
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
				float4 color : COLOR;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			half _ColorSlider;
			half _ColorSliderB;
			
			v2f vert (appdata v)
			{
				v2f o = (v2f)0 ; 							// Initializing "v2f o" to avoid warning message.
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.color.r = (v.vertex.x + (_ColorSlider*0.5))*_ColorSlider;
				o.color.g = (v.vertex.z + (_ColorSlider*0.5))*_ColorSlider;
				o.color.b = _ColorSliderB;

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv) * i.color;

				return col;
			}
			ENDCG
		}
	}
}
