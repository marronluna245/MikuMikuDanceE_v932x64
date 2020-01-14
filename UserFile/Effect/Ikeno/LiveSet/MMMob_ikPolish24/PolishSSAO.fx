///////////////////////////////////////////////////////////////////////////////
//
///////////////////////////////////////////////////////////////////////////////

#include "ikPolishShader.fxsub"
#include "structs.fxsub"
#include "mmdutil.fxsub"
#include "colorutil.fxsub"

// ���W�ϊ��s��
float4x4 matW				: WORLD;
float4x4 matV				: VIEW;
float4x4 matP				: PROJECTION;
float4x4 CalcViewProjMatrix(float4x4 v, float4x4 p)
{
	p._11_22 *= GIFrameScale;
	return mul(v, p);
}
static float4x4 matVP = CalcViewProjMatrix(matV, matP);

// �}�e���A���F
float4 MaterialDiffuse   : DIFFUSE  < string Object = "Geometry"; >;

bool use_texture;

//=============================================================================
// MikuMikuMob�Ή� ��������

// &InsertHeader;  ������MikuMikuMob�ݒ�w�b�_�R�[�h���}������܂�

// MikuMikuMob�Ή� �����܂�
//=============================================================================

//-----------------------------------------------------------------------------
// �I�u�W�F�N�g�`��

struct VS_OUTPUT {
	float4 Pos	   : POSITION;	// �ˉe�ϊ����W
	float4 TexDistance	   : TEXCOORD0;   // �e�N�X�`�� + �[�x
	float4 Color		: COLOR0;	// �f�B�t���[�Y�F
};

VS_OUTPUT Basic_VS(VS_AL_INPUT IN, int vIndex : _INDEX)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	float4 LPos = mul( IN.Pos, matW );
	float4 WPos = MOB_TransformPosition(LPos, vIndex);
	Out.Pos = mul( WPos, matVP );

	Out.TexDistance.xy = IN.Tex;
	Out.TexDistance.z = mul(WPos, matV).z;

	Out.Color = saturate( MaterialDiffuse );

	return Out;
}

float4 Basic_PS(VS_OUTPUT IN, uniform bool bUseTexture) : COLOR
{
	#if IGNORE_TEXTURE == 0
	float4 Color = IN.Color;
	if (bUseTexture) Color *= GetTextureColor(IN.TexDistance.xy);
	clip(Color.a - AlphaThreshold);
	#endif

	return float4(IN.TexDistance.z, 0,0,1);
}

#define OBJECT_TEC(name, mmdpass) \
	technique name < string MMDPass = mmdpass; \
		string Script = MOB_LOOPSCRIPT_OBJECT; \
	> { \
		pass DrawObject { \
			AlphaTestEnable = FALSE; AlphaBlendEnable = FALSE; \
			VertexShader = compile vs_3_0 Basic_VS(); \
			PixelShader  = compile ps_3_0 Basic_PS(use_texture); \
		} \
	}


OBJECT_TEC(MainTec0, "object")
OBJECT_TEC(MainTecBS1, "object_ss")

technique EdgeTec < string MMDPass = "edge"; > {}
technique ShadowTec < string MMDPass = "shadow"; > {}
technique ZplotTec < string MMDPass = "zplot"; > {}


//-----------------------------------------------------------------------------