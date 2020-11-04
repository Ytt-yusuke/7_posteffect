Shader "Unlit/BlurShader2"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Radius("Radius", Range(0,100)) = 5.0
    }
        SubShader
        {
            Cull off Zwrite off Ztest Always
            Pass
            {
                CGPROGRAM
                #include "UnityCustomRenderTexture.cginc"

                #pragma vertex CustomRenderTextureVertexShader
                #pragma fragment frag


                sampler2D _MainTex;
                float4 _MainTex_TexelSize;
                float _Radius;

                fixed4 frag(v2f_customrendertexture i) : SV_Target
                {

                    // sample the texture
                    float2 scale = _MainTex_TexelSize.xy * _Radius;
                    fixed4 col = tex2D(_MainTex, i.globalTexcoord);
                    float weight = 1.0;
                    const float S2 = 1.0 / 50.0;

                    float w1 = exp(-0.5 * 1.5 * 1.5 * S2);
                    col += w1 * tex2D(_MainTex, i.globalTexcoord + float2(0, 1.5) * scale);
                    col += w1 * tex2D(_MainTex, i.globalTexcoord - float2(0, 1.5) * scale);
                    weight += 2.0 * w1;

                    float w2 = exp(-0.5 * 3.5 * 3.5 * S2);
                    col += w2 * tex2D(_MainTex, i.globalTexcoord + float2(0, 3.5) * scale);
                    col += w2 * tex2D(_MainTex, i.globalTexcoord - float2(0, 3.5) * scale);
                    weight += 2.0 * w2;

                    float w3 = exp(-0.5 * 5.5 * 5.5 * S2);
                    col += w3 * tex2D(_MainTex, i.globalTexcoord + float2(0, 5.5) * scale);
                    col += w3 * tex2D(_MainTex, i.globalTexcoord - float2(0, 5.5) * scale);
                    weight += 2.0 * w3;

                    float w4 = exp(-0.5 * 7.5 * 7.5 * S2);
                    col += w4 * tex2D(_MainTex, i.globalTexcoord + float2(0, 7.5) * scale);
                    col += w4 * tex2D(_MainTex, i.globalTexcoord - float2(0, 7.5) * scale);
                    weight += 2.0 * w4;

                    float w5 = exp(-0.5 * 9.5 * 9.5 * S2);
                    col += w5 * tex2D(_MainTex, i.globalTexcoord + float2(0, 9.5) * scale);
                    col += w5 * tex2D(_MainTex, i.globalTexcoord - float2(0, 9.5) * scale);
                    weight += 2.0 * w5;


                    col /= weight;
                    return col;
                }
                ENDCG
            }
        }
}
