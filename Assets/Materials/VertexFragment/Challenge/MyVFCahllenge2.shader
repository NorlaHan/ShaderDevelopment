Shader "Holistic/MyVFCahllenge2"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_ShadowTint ("Shadow Tint", Color) = (1,0,0,1)
		_ShadowSlider ("Shadow Slider", Range(0,1)) = 0.2
	}
	SubShader
	{
		// Drawing of the material with the lighting on it.
		Pass {
			Tags {"LightMode"="ForwardBase"}
	
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight	// Receive shadow required
			
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"
			#include "Lighting.cginc"			// Receive shadow required
			#include "AutoLight.cginc"			// Receive shadow required

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
//				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				fixed4 diff : COLOR0;
				float4 pos : SV_POSITION;		// "vertex" --> "pos"
				SHADOW_COORDS(1)				// Receive shadow required
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);		// #include "UnityLightingCommon.cginc"		// "vertex" --> "pos"
//				o.uv = TRANSFORM_TEX(v.uv, _MainTex);		// float2 uv : TEXCOORD0;
				o.uv = v.texcoord; 							// float4 texcoord : TEXCOORD0;
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);			// float3 normal : NORMAL;
				half nl = max(0,dot(worldNormal, _WorldSpaceLightPos0.xyz));
				o.diff = nl * _LightColor0;										// #include "UnityLightingCommon.cginc"
				TRANSFER_SHADOW(o);		// Receive shadow required, if "pos" is called "vertex" will be error.

				return o;
			}

			sampler2D _MainTex;
			half4 _ShadowTint;
			float _ShadowSlider;

//			float4 _MainTex_ST;

			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				fixed shadow = SHADOW_ATTENUATION(i);	// Receive shadow required
				col *= (i.diff ) * shadow + (shadow < _ShadowSlider ? _ShadowTint : 0); 
				return col;
			}
			ENDCG
		}
		// Draw shadow
		Pass {
			Tags {"LightMode"="ShadowCaster"}

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster

			#include "UnityCG.cginc"

			struct appdata {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
			};

			struct v2f {
				V2F_SHADOW_CASTER;
			};

			v2f vert(appdata v){
				v2f o;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
				return o;
			}

			float4 frag(v2f i) : SV_Target{
				SHADOW_CASTER_FRAGMENT(i)
			}
			ENDCG		// Don't forget this
		}
	}
}
