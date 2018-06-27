Shader "Holistic/Glass"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) = "bump" {}
		_ScaleUV ("Scale UV", Range(1,20)) = 1
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent"}
		GrabPass{}
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
				float4 uvgrab : TEXCOORD1;
				float2 uvbump : TEXCOORD2;
				float4 vertex : SV_POSITION;
			};

			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize;	// The size of the pixel in the texture. float4 (1/width,1/height,width,height)
			sampler2D _MainTex;
			float4 _MainTex_ST;
			// For Bump map
			sampler2D _BumpMap;
			float4 _BumpMap_ST;
			// -------------------
			float _ScaleUV;

			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex); // putting down world space into clip space.

				// ---------The fix for the flipped UV
				#if UNITY_UV_STARTS_AT_TOP
					float scale = -1.0;
				#else
					float scale = 1.0;
				#endif
				// Caculate UV for our grab texture
				o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y * scale) + o.vertex.w) * 0.5;
				// ---------End of the fix.
				o.uvgrab.zw = o.vertex.zw;

				// Main Texture UV
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				// For Bump map
				o.uvbump = TRANSFORM_TEX(v.uv, _BumpMap) * scale;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				half2 bump = UnpackNormal(tex2D(_BumpMap, i.uvbump)).rg;
				// how much to change the background.
				float2 offset = bump * _ScaleUV * _GrabTexture_TexelSize.xy;
				i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;

				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				// For the tint
				fixed4 tint = tex2D (_MainTex, i.uv);
				col *= tint;
				// ------------
				return col;
			}
			ENDCG
		}
	}
}
