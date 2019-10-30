Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
		_Radius("Radius",Range(0.00,100.)) = 5.0
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }
			LOD 100

			Pass
			{
				CGPROGRAM

				#include "UnityCustomRenderTexture.cginc"
				#pragma vertex CustomRenderTextureVertexShader
				#pragma fragment frag

				sampler2D _MainTex;
				float4 _MainTex_TexelSize;
				float _Radius;

				fixed4 frag (v2f_customrendertexture i) : SV_Target
				{
					float2 scale = _MainTex_TexelSize.xy * _Radius;
					// sample the texture
					fixed4 col = fixed4(0,0,0,1);
					col += tex2D(_MainTex, i.globalTexcoord + float2(-1, 0) * scale);
					col += tex2D(_MainTex, i.globalTexcoord + float2(+1, 0) * scale);
					col += tex2D(_MainTex, i.globalTexcoord + float2(0, -1) * scale);
					col += tex2D(_MainTex, i.globalTexcoord + float2(0, +1) * scale);
					col /= 4.0;

					return col;
				}
				ENDCG
        }
    }
}
