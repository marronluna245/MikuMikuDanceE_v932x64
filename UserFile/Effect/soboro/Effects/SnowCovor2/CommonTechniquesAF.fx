// �e�N�j�b�N�̃��X�g�E�ٕ����t�B���^�����O�g�p��


// �����_�����O�^�[�Q�b�g�̃N���A�l
float4 TexClearColor = {0,0,0,0};
float TexClearDepth  = 1.0;


// �I�u�W�F�N�g�`��p�e�N�j�b�N�i�A�N�Z�T���p�j
technique MainTec0 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(false, false, false);
        PixelShader  = compile ps_2_0 Basic_PS(false, false, false);
    }
}

technique MainTec1 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = false; 
    string Script= 
        "RenderColorTarget0=UseMipmapObjectTexture;"
            "RenderDepthStencilTarget=DepthBuffer;"
                "ClearSetColor=TexClearColor; ClearSetDepth=TexClearDepth;"
                "Clear=Color; Clear=Depth;"
            "Pass=CreateMipmap;"
        "RenderColorTarget0=;"
            "RenderDepthStencilTarget=;"
            "Pass=DrawObject;"
        ;
 > {
    pass CreateMipmap < string Script= "Draw=Buffer;"; > {
        AlphaBlendEnable = FALSE;
        ZEnable = FALSE;
        VertexShader = compile vs_2_0 VS_MipMapCreater();
        PixelShader  = compile ps_2_0 PS_MipMapCreater();
    }
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(true, false, false);
        PixelShader  = compile ps_2_0 Basic_PS(true, false, false);
    }
}

technique MainTec2 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(false, true, false);
        PixelShader  = compile ps_2_0 Basic_PS(false, true, false);
    }
}

technique MainTec3 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = false; 
    string Script= 
        "RenderColorTarget0=UseMipmapObjectTexture;"
            "RenderDepthStencilTarget=DepthBuffer;"
                "ClearSetColor=TexClearColor; ClearSetDepth=TexClearDepth;"
                "Clear=Color; Clear=Depth;"
            "Pass=CreateMipmap;"
        "RenderColorTarget0=;"
            "RenderDepthStencilTarget=;"
            "Pass=DrawObject;"
        ;
 > {
    pass CreateMipmap < string Script= "Draw=Buffer;"; > {
        AlphaBlendEnable = FALSE;
        ZEnable = FALSE;
        VertexShader = compile vs_2_0 VS_MipMapCreater();
        PixelShader  = compile ps_2_0 PS_MipMapCreater();
    }
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(true, true, false);
        PixelShader  = compile ps_2_0 Basic_PS(true, true, false);
    }
}

// �I�u�W�F�N�g�`��p�e�N�j�b�N�iPMD���f���p�j
technique MainTec4 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(false, false, true);
        PixelShader  = compile ps_2_0 Basic_PS(false, false, true);
    }
}

technique MainTec5 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = true; 
    string Script= 
        "RenderColorTarget0=UseMipmapObjectTexture;"
            "RenderDepthStencilTarget=DepthBuffer;"
                "ClearSetColor=TexClearColor; ClearSetDepth=TexClearDepth;"
                "Clear=Color; Clear=Depth;"
            "Pass=CreateMipmap;"
        "RenderColorTarget0=;"
            "RenderDepthStencilTarget=;"
            "Pass=DrawObject;"
        ;
 > {
    pass CreateMipmap < string Script= "Draw=Buffer;"; > {
        AlphaBlendEnable = FALSE;
        ZEnable = FALSE;
        VertexShader = compile vs_2_0 VS_MipMapCreater();
        PixelShader  = compile ps_2_0 PS_MipMapCreater();
    }
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(true, false, true);
        PixelShader  = compile ps_2_0 Basic_PS(true, false, true);
    }
}

technique MainTec6 < string MMDPass = "object"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(false, true, true);
        PixelShader  = compile ps_2_0 Basic_PS(false, true, true);
    }
}

technique MainTec7 < string MMDPass = "object"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = true; 
    string Script= 
        "RenderColorTarget0=UseMipmapObjectTexture;"
            "RenderDepthStencilTarget=DepthBuffer;"
                "ClearSetColor=TexClearColor; ClearSetDepth=TexClearDepth;"
                "Clear=Color; Clear=Depth;"
            "Pass=CreateMipmap;"
        "RenderColorTarget0=;"
            "RenderDepthStencilTarget=;"
            "Pass=DrawObject;"
        ;
 > {
    pass CreateMipmap < string Script= "Draw=Buffer;"; > {
        AlphaBlendEnable = FALSE;
        ZEnable = FALSE;
        VertexShader = compile vs_2_0 VS_MipMapCreater();
        PixelShader  = compile ps_2_0 PS_MipMapCreater();
    }
    pass DrawObject {
        VertexShader = compile vs_2_0 Basic_VS(true, true, true);
        PixelShader  = compile ps_2_0 Basic_PS(true, true, true);
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////
// �I�u�W�F�N�g�`��i�Z���t�V���h�EON�j
// �Z���t�V���h�EOFF���Ɠ����`����s��

// �I�u�W�F�N�g�`��p�e�N�j�b�N�i�A�N�Z�T���p�j
technique MainTecBS0  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, false, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, false, false);
    }
}

technique MainTecBS1  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = false; 
    string Script= 
        "RenderColorTarget0=UseMipmapObjectTexture;"
            "RenderDepthStencilTarget=DepthBuffer;"
                "ClearSetColor=TexClearColor; ClearSetDepth=TexClearDepth;"
                "Clear=Color; Clear=Depth;"
            "Pass=CreateMipmap;"
        "RenderColorTarget0=;"
            "RenderDepthStencilTarget=;"
            "Pass=DrawObject;"
        ;
 > {
    pass CreateMipmap < string Script= "Draw=Buffer;"; > {
        AlphaBlendEnable = FALSE;
        ZEnable = FALSE;
        VertexShader = compile vs_2_0 VS_MipMapCreater();
        PixelShader  = compile ps_2_0 PS_MipMapCreater();
    }
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, false, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, false, false);
    }
}

technique MainTecBS2  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = false; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, true, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, true, false);
    }
}

technique MainTecBS3  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = false; 
    string Script= 
        "RenderColorTarget0=UseMipmapObjectTexture;"
            "RenderDepthStencilTarget=DepthBuffer;"
                "ClearSetColor=TexClearColor; ClearSetDepth=TexClearDepth;"
                "Clear=Color; Clear=Depth;"
            "Pass=CreateMipmap;"
        "RenderColorTarget0=;"
            "RenderDepthStencilTarget=;"
            "Pass=DrawObject;"
        ;
 > {
    pass CreateMipmap < string Script= "Draw=Buffer;"; > {
        AlphaBlendEnable = FALSE;
        ZEnable = FALSE;
        VertexShader = compile vs_2_0 VS_MipMapCreater();
        PixelShader  = compile ps_2_0 PS_MipMapCreater();
    }
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, true, false);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, true, false);
    }
}

// �I�u�W�F�N�g�`��p�e�N�j�b�N�iPMD���f���p�j
technique MainTecBS4  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = false; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, false, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, false, true);
    }
}

technique MainTecBS5  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = false; bool UseToon = true; 
    string Script= 
        "RenderColorTarget0=UseMipmapObjectTexture;"
            "RenderDepthStencilTarget=DepthBuffer;"
                "ClearSetColor=TexClearColor; ClearSetDepth=TexClearDepth;"
                "Clear=Color; Clear=Depth;"
            "Pass=CreateMipmap;"
        "RenderColorTarget0=;"
            "RenderDepthStencilTarget=;"
            "Pass=DrawObject;"
        ;
 > {
    pass CreateMipmap < string Script= "Draw=Buffer;"; > {
        AlphaBlendEnable = FALSE;
        ZEnable = FALSE;
        VertexShader = compile vs_2_0 VS_MipMapCreater();
        PixelShader  = compile ps_2_0 PS_MipMapCreater();
    }
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, false, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, false, true);
    }
}

technique MainTecBS6  < string MMDPass = "object_ss"; bool UseTexture = false; bool UseSphereMap = true; bool UseToon = true; 
    string Script= 
        "RenderColorTarget0=UseMipmapObjectTexture;"
            "RenderDepthStencilTarget=DepthBuffer;"
                "ClearSetColor=TexClearColor; ClearSetDepth=TexClearDepth;"
                "Clear=Color; Clear=Depth;"
            "Pass=CreateMipmap;"
        "RenderColorTarget0=;"
            "RenderDepthStencilTarget=;"
            "Pass=DrawObject;"
        ;
 > {
    pass CreateMipmap < string Script= "Draw=Buffer;"; > {
        AlphaBlendEnable = FALSE;
        ZEnable = FALSE;
        VertexShader = compile vs_2_0 VS_MipMapCreater();
        PixelShader  = compile ps_2_0 PS_MipMapCreater();
    }
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(false, true, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(false, true, true);
    }
}

technique MainTecBS7  < string MMDPass = "object_ss"; bool UseTexture = true; bool UseSphereMap = true; bool UseToon = true; > {
    pass DrawObject {
        VertexShader = compile vs_3_0 BufferShadow_VS(true, true, true);
        PixelShader  = compile ps_3_0 BufferShadow_PS(true, true, true);
    }
}