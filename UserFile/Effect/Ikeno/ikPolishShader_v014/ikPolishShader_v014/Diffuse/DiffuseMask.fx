////////////////////////////////////////////////////////////////////////////////////////////////
// �f�肱�܂������Ȃ��ގ��ɐݒ肷��
////////////////////////////////////////////////////////////////////////////////////////////////

#include "../ikPolishShader.fxsub"

///////////////////////////////////////////////////////////////////////////////////////////////

// ���W�ϊ��s��
float4x4 matW				: WORLD;
float4x4 matWV				: WORLDVIEW;
float4x4 matP				: PROJECTION;
float4x4 CalcViewProjMatrix(float4x4 v, float4x4 p)
{
	p._11_22 *= GIFrameScale;
	return mul(v, p);
}
static float4x4 matWVP = CalcViewProjMatrix(matWV, matP);

float4x4 matLightWVP : WORLDVIEWPROJECTION < string Object = "Light"; >;

float3 LightDirection : DIRECTION < string Object = "Light"; >;

// �}�e���A���F
float4 MaterialDiffuse   : DIFFUSE  < string Object = "Geometry"; >;
float3 MaterialAmbient   : AMBIENT  < string Object = "Geometry"; >;
float3 MaterialEmissive  : EMISSIVE < string Object = "Geometry"; >;
float3 MaterialSpecular  : SPECULAR < string Object = "Geometry"; >;
float3 MaterialToon      : TOONCOLOR;
// ���C�g�F
float3 LightDiffuse   : DIFFUSE   < string Object = "Light"; >;
float3 LightAmbient   : AMBIENT   < string Object = "Light"; >;
float3 LightSpecular  : SPECULAR  < string Object = "Light"; >;
static float4 DiffuseColor  = MaterialDiffuse * float4(LightDiffuse, 1.0f);
static float3 AmbientColor  = MaterialAmbient * LightAmbient + MaterialEmissive;

// �e�N�X�`���ގ����[�t�l
float4 TextureAddValue  : ADDINGTEXTURE;
float4 TextureMulValue  : MULTIPLYINGTEXTURE;
float4 SphereAddValue   : ADDINGSPHERETEXTURE;
float4 SphereMulValue   : MULTIPLYINGSPHERETEXTURE;

bool use_texture;
bool use_spheremap;
bool use_subtexture;
bool use_toon;

// �I�u�W�F�N�g�̃e�N�X�`��
texture ObjectTexture: MATERIALTEXTURE;
sampler ObjTexSampler = sampler_state {
    texture = <ObjectTexture>;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
    MIPFILTER = LINEAR;
    ADDRESSU  = WRAP;
    ADDRESSV  = WRAP;
};

shared texture PPPGIDepthMapRT: RENDERCOLORTARGET;

////////////////////////////////////////////////////////////////////////////////////////////////

    struct MMM_SKINNING_INPUT{
        float4 Pos : POSITION;
        float2 Tex : TEXCOORD0;
        float4 AddUV1 : TEXCOORD1;
        float4 AddUV2 : TEXCOORD2;
        float4 AddUV3 : TEXCOORD3;
        float4 Normal : NORMAL;
        
    };

	inline void GetPositionNormal(MMM_SKINNING_INPUT IN, out float4 p, out float3 n)
	{
		p = IN.Pos;
		n = IN.Normal;
	}


///////////////////////////////////////////////////////////////////////////////////////////////
// �I�u�W�F�N�g�`��

struct VS_OUTPUT {
    float4 Pos       : POSITION;    // �ˉe�ϊ����W
    float4 Tex       : TEXCOORD0;   // �e�N�X�`��
    float3 Normal    : TEXCOORD1;   // �@��
	float Distance	: TEXCOORD3;

    float4 Color     : COLOR0;      // �f�B�t���[�Y�F
};

struct PS_OUT_MRT
{
	float4 Color		: COLOR0;
	float4 Normal		: COLOR1;
};



VS_OUTPUT Basic_VS(MMM_SKINNING_INPUT IN)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	float4 pos;
	float3 Normal;
	GetPositionNormal(IN, pos, Normal);

    // ���[���h���W�ϊ�
    // �J�������_�̃r���[�ˉe�ϊ�
    Out.Pos = mul( pos, matWVP );
	Out.Distance = mul(pos, matWV).z;

    Out.Normal = normalize( mul( Normal, (float3x3)matW ) );

    ////////////////////////

    Out.Tex.xy = IN.Tex; //�e�N�X�`��UV

   // �f�B�t���[�Y�F�{�A���r�G���g�F �v�Z
    Out.Color.rgb = 1;
    Out.Color.a = DiffuseColor.a;
    Out.Color = saturate( Out.Color );

    return Out;
}


// �s�N�Z���V�F�[�_
PS_OUT_MRT Basic_PS(VS_OUTPUT IN, uniform bool useShadow)
{
	float4 albed = 1;

    if(use_texture){
        // �e�N�X�`���K�p
        float4 TexColor = tex2D(ObjTexSampler,IN.Tex.xy);
        // �e�N�X�`���ގ����[�t��
        TexColor.rgb = lerp(1, TexColor * TextureMulValue + TextureAddValue, TextureMulValue.a + TextureAddValue.a).rgb;
        albed *= TexColor;
    }

    float4 Color = albed * IN.Color;
	clip(Color.a - AlphaThreshold);

	Color.rgb = 0;

	PS_OUT_MRT Out;
	Out.Color = Color;
	Out.Normal = float4(IN.Distance, 0,0,1);

	return Out;
}


#define OBJECT_TEC(name, mmdpass, shadow) \
	technique name < string MMDPass = mmdpass; \
	string Script = \
		"RenderColorTarget0=;" \
		"RenderColorTarget1=PPPGIDepthMapRT;" \
		"RenderDepthStencilTarget=;" \
		"Pass=DrawObject;" \
		"RenderColorTarget1=;" \
	; \
	> { \
		pass DrawObject { \
			AlphaTestEnable = FALSE; AlphaBlendEnable = FALSE; \
			VertexShader = compile vs_3_0 Basic_VS(); \
			PixelShader  = compile ps_3_0 Basic_PS(shadow); \
		} \
	}


OBJECT_TEC(MainTec0, "object", false)
OBJECT_TEC(MainTecBS1, "object_ss", true)

technique EdgeTec < string MMDPass = "edge"; > {}
technique ShadowTec < string MMDPass = "shadow"; > {}
technique ZplotTec < string MMDPass = "zplot"; > {}


///////////////////////////////////////////////////////////////////////////////////////////////