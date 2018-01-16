// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "My/simpleTerminal"
{
	Properties
	{
		_Terminal_AOtga("Terminal_AO.tga", 2D) = "white" {}
		_Terminal_Colortga("Terminal_Color.tga", 2D) = "white" {}
		_Terminal_Metaltga("Terminal_Metal.tga", 2D) = "white" {}
		_Terminal_Emisstga("Terminal_Emiss.tga", 2D) = "white" {}
		_Terminal_Normaltga("Terminal_Normal.tga", 2D) = "white" {}
		_Terminal_ScreenMask("Terminal_ScreenMask", 2D) = "white" {}
		_ScreenTexture("Screen Texture", 2D) = "black" {}
		_ScreenBlend("ScreenBlend", Range( 0 , 1)) = 0.5
		_ScreenTextureRect("Screen Texture Rect", Vector) = (3.7,5.58,-2,-1.7)
		_ScreenImmesionIntensity("ScreenImmesion Intensity", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Terminal_Normaltga;
		uniform float4 _Terminal_Normaltga_ST;
		uniform sampler2D _Terminal_Colortga;
		uniform float4 _Terminal_Colortga_ST;
		uniform sampler2D _Terminal_ScreenMask;
		uniform float4 _Terminal_ScreenMask_ST;
		uniform sampler2D _ScreenTexture;
		uniform fixed4 _ScreenTextureRect;
		uniform float _ScreenBlend;
		uniform float _ScreenImmesionIntensity;
		uniform sampler2D _Terminal_Emisstga;
		uniform float4 _Terminal_Emisstga_ST;
		uniform sampler2D _Terminal_Metaltga;
		uniform float4 _Terminal_Metaltga_ST;
		uniform sampler2D _Terminal_AOtga;
		uniform float4 _Terminal_AOtga_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Terminal_Normaltga = i.uv_texcoord * _Terminal_Normaltga_ST.xy + _Terminal_Normaltga_ST.zw;
			o.Normal = tex2D( _Terminal_Normaltga, uv_Terminal_Normaltga ).rgb;
			float2 uv_Terminal_Colortga = i.uv_texcoord * _Terminal_Colortga_ST.xy + _Terminal_Colortga_ST.zw;
			float4 tex2DNode2 = tex2D( _Terminal_Colortga, uv_Terminal_Colortga );
			float2 uv_Terminal_ScreenMask = i.uv_texcoord * _Terminal_ScreenMask_ST.xy + _Terminal_ScreenMask_ST.zw;
			float4 tex2DNode8 = tex2D( _Terminal_ScreenMask, uv_Terminal_ScreenMask );
			float2 appendResult27 = (float2(_ScreenTextureRect.x , _ScreenTextureRect.y));
			float2 appendResult29 = (float2(_ScreenTextureRect.z , _ScreenTextureRect.w));
			float2 uv_TexCoord21 = i.uv_texcoord * appendResult27 + appendResult29;
			float4 temp_output_12_0 = ( tex2D( _ScreenTexture, uv_TexCoord21 ) * tex2DNode8.r );
			float4 lerpResult15 = lerp( ( tex2DNode2 * tex2DNode8.r ) , temp_output_12_0 , _ScreenBlend);
			o.Albedo = ( ( tex2DNode2 * ( 1.0 - tex2DNode8.r ) ) + lerpResult15 ).rgb;
			float2 uv_Terminal_Emisstga = i.uv_texcoord * _Terminal_Emisstga_ST.xy + _Terminal_Emisstga_ST.zw;
			o.Emission = ( ( temp_output_12_0 * _ScreenImmesionIntensity ) + tex2D( _Terminal_Emisstga, uv_Terminal_Emisstga ) ).rgb;
			float2 uv_Terminal_Metaltga = i.uv_texcoord * _Terminal_Metaltga_ST.xy + _Terminal_Metaltga_ST.zw;
			o.Metallic = tex2D( _Terminal_Metaltga, uv_Terminal_Metaltga ).r;
			float2 uv_Terminal_AOtga = i.uv_texcoord * _Terminal_AOtga_ST.xy + _Terminal_AOtga_ST.zw;
			o.Occlusion = tex2D( _Terminal_AOtga, uv_Terminal_AOtga ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
512;13;1379;830;562.4791;1255.652;1;True;False
Node;AmplifyShaderEditor.Vector4Node;28;-1555.223,-726.3997;Fixed;False;Property;_ScreenTextureRect;Screen Texture Rect;12;0;Create;3.7,5.58,-2,-1.7;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;27;-1258.354,-748.4115;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;29;-1262.354,-625.4115;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;8;-1348.721,-378.6789;Float;True;Property;_Terminal_ScreenMask;Terminal_ScreenMask;7;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-1076.195,-772.652;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;33;-1006.295,-461.6975;Float;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-1003.78,-233.7864;Float;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-308.7562,-967.4442;Float;True;Property;_Terminal_Colortga;Terminal_Color.tga;1;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;35;-527.9485,-371.5063;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-807.013,-734.0378;Float;True;Property;_ScreenTexture;Screen Texture;8;0;Create;None;None;True;0;False;black;LockedToTexture2D;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;34;-541.5668,-436.2979;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;36;-506.1991,-217.9569;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;122.1462,-734.1735;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-361.8201,123.1458;Float;False;Property;_ScreenImmesionIntensity;ScreenImmesion Intensity;13;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-466.6421,-733.8809;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;37;393.6669,-551.7341;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-69.58909,-320.3147;Float;False;Property;_ScreenBlend;ScreenBlend;10;0;Create;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-31.64487,-139.0482;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;15;390.4725,-474.2432;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;182.1963,55.09734;Float;True;Property;_Terminal_Emisstga;Terminal_Emiss.tga;3;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;507.3746,-800.3586;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;1055.045,32.84294;Float;True;Property;_Terminal_Metaltga;Terminal_Metal.tga;2;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;32;520.1597,-146.3907;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;751.8685,-617.9418;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;23;-1591.695,-973.1602;Fixed;False;Property;_offset;offset;11;0;Create;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;7;969.5397,-406.8846;Float;True;Property;_Terminal_Normaltga;Terminal_Normal.tga;6;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;1055.782,241.6646;Float;True;Property;_Terminal_AOtga;Terminal_AO.tga;0;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1225.491,-1025.465;Float;True;Property;_Terminal_Spectga;Terminal_Spec.tga;5;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;22;-1427.695,-977.1602;Fixed;False;Property;_scale;scale;9;0;Create;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;5;1059.254,449.5747;Float;True;Property;_Terminal_Cavitytga;Terminal_Cavity.tga;4;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;38;-826.929,-959.0116;Float;True;Property;_Border;Border;14;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1504.393,-339.8317;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;My/simpleTerminal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;27;0;28;1
WireConnection;27;1;28;2
WireConnection;29;0;28;3
WireConnection;29;1;28;4
WireConnection;21;0;27;0
WireConnection;21;1;29;0
WireConnection;33;0;8;1
WireConnection;17;0;8;1
WireConnection;35;0;33;0
WireConnection;11;1;21;0
WireConnection;34;0;33;0
WireConnection;36;0;17;0
WireConnection;19;0;2;0
WireConnection;19;1;35;0
WireConnection;12;0;11;0
WireConnection;12;1;34;0
WireConnection;37;0;36;0
WireConnection;31;0;12;0
WireConnection;31;1;30;0
WireConnection;15;0;19;0
WireConnection;15;1;12;0
WireConnection;15;2;16;0
WireConnection;18;0;2;0
WireConnection;18;1;37;0
WireConnection;32;0;31;0
WireConnection;32;1;4;0
WireConnection;20;0;18;0
WireConnection;20;1;15;0
WireConnection;38;1;21;0
WireConnection;0;0;20;0
WireConnection;0;1;7;0
WireConnection;0;2;32;0
WireConnection;0;3;3;0
WireConnection;0;5;1;0
ASEEND*/
//CHKSM=A747969A6F1F95634DE82CEC3FE041794E1AD5FA