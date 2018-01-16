// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "My/Dissolve"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 16.9
		_noise_gen_1_param("noise_gen_1_param", Vector) = (0,0,0,0)
		_noise_gen_1_offset("noise_gen_1_offset", Vector) = (0,0,0,0)
		_noise_gen_2_param("noise_gen_2_param", Vector) = (0,0,0,0)
		_noise_gen_2_offset("noise_gen_2_offset", Vector) = (0,0,0,0)
		_noise_gen_3_param("noise_gen_3_param", Vector) = (0,0,0,0)
		_noise_gen_3_offset("noise_gen_3_offset", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "Tessellation.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _noise_gen_1_param;
		uniform float2 _noise_gen_1_offset;
		uniform float4 _noise_gen_2_param;
		uniform float2 _noise_gen_2_offset;
		uniform float4 _noise_gen_3_param;
		uniform float2 _noise_gen_3_offset;
		uniform float _EdgeLength;


		float3 mod3D289( float3 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 mod3D289( float4 x ) { return x - floor( x / 289.0 ) * 289.0; }

		float4 permute( float4 x ) { return mod3D289( ( x * 34.0 + 1.0 ) * x ); }

		float4 taylorInvSqrt( float4 r ) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise( float3 v )
		{
			const float2 C = float2( 1.0 / 6.0, 1.0 / 3.0 );
			float3 i = floor( v + dot( v, C.yyy ) );
			float3 x0 = v - i + dot( i, C.xxx );
			float3 g = step( x0.yzx, x0.xyz );
			float3 l = 1.0 - g;
			float3 i1 = min( g.xyz, l.zxy );
			float3 i2 = max( g.xyz, l.zxy );
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod3D289( i);
			float4 p = permute( permute( permute( i.z + float4( 0.0, i1.z, i2.z, 1.0 ) ) + i.y + float4( 0.0, i1.y, i2.y, 1.0 ) ) + i.x + float4( 0.0, i1.x, i2.x, 1.0 ) );
			float4 j = p - 49.0 * floor( p / 49.0 );  // mod(p,7*7)
			float4 x_ = floor( j / 7.0 );
			float4 y_ = floor( j - 7.0 * x_ );  // mod(j,N)
			float4 x = ( x_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 y = ( y_ * 2.0 + 0.5 ) / 7.0 - 1.0;
			float4 h = 1.0 - abs( x ) - abs( y );
			float4 b0 = float4( x.xy, y.xy );
			float4 b1 = float4( x.zw, y.zw );
			float4 s0 = floor( b0 ) * 2.0 + 1.0;
			float4 s1 = floor( b1 ) * 2.0 + 1.0;
			float4 sh = -step( h, 0.0 );
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3( a0.xy, h.x );
			float3 g1 = float3( a0.zw, h.y );
			float3 g2 = float3( a1.xy, h.z );
			float3 g3 = float3( a1.zw, h.w );
			float4 norm = taylorInvSqrt( float4( dot( g0, g0 ), dot( g1, g1 ), dot( g2, g2 ), dot( g3, g3 ) ) );
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max( 0.6 - float4( dot( x0, x0 ), dot( x1, x1 ), dot( x2, x2 ), dot( x3, x3 ) ), 0.0 );
			m = m* m;
			m = m* m;
			float4 px = float4( dot( x0, g0 ), dot( x1, g1 ), dot( x2, g2 ), dot( x3, g3 ) );
			return 42.0 * dot( m, px);
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float temp_output_23_0_g44 = _noise_gen_1_param.x;
			float2 appendResult13_g44 = (float2(temp_output_23_0_g44 , temp_output_23_0_g44));
			float2 uv_TexCoord5_g44 = i.uv_texcoord * appendResult13_g44 + _noise_gen_1_offset;
			float3 appendResult7_g44 = (float3(uv_TexCoord5_g44.x , uv_TexCoord5_g44.y , _noise_gen_1_param.y));
			float simplePerlin3D10_g44 = snoise( appendResult7_g44 );
			float temp_output_23_0_g45 = _noise_gen_2_param.x;
			float2 appendResult13_g45 = (float2(temp_output_23_0_g45 , temp_output_23_0_g45));
			float2 uv_TexCoord5_g45 = i.uv_texcoord * appendResult13_g45 + _noise_gen_2_offset;
			float3 appendResult7_g45 = (float3(uv_TexCoord5_g45.x , uv_TexCoord5_g45.y , _noise_gen_2_param.y));
			float simplePerlin3D10_g45 = snoise( appendResult7_g45 );
			float temp_output_23_0_g46 = _noise_gen_3_param.x;
			float2 appendResult13_g46 = (float2(temp_output_23_0_g46 , temp_output_23_0_g46));
			float2 uv_TexCoord5_g46 = i.uv_texcoord * appendResult13_g46 + _noise_gen_3_offset;
			float3 appendResult7_g46 = (float3(uv_TexCoord5_g46.x , uv_TexCoord5_g46.y , _noise_gen_3_param.y));
			float simplePerlin3D10_g46 = snoise( appendResult7_g46 );
			float temp_output_76_0 = ( (_noise_gen_1_param.w + (simplePerlin3D10_g44 - -1.0) * (_noise_gen_1_param.z - _noise_gen_1_param.w) / (1.0 - -1.0)) + (_noise_gen_2_param.w + (simplePerlin3D10_g45 - -1.0) * (_noise_gen_2_param.z - _noise_gen_2_param.w) / (1.0 - -1.0)) + (_noise_gen_3_param.w + (simplePerlin3D10_g46 - -1.0) * (_noise_gen_3_param.z - _noise_gen_3_param.w) / (1.0 - -1.0)) );
			float3 appendResult40 = (float3(temp_output_76_0 , temp_output_76_0 , temp_output_76_0));
			o.Emission = appendResult40;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
2044;274;1387;447;3149.185;323.675;3.420882;True;True
Node;AmplifyShaderEditor.Vector4Node;98;-855.1091,-226.385;Float;False;Property;_noise_gen_1_param;noise_gen_1_param;7;0;Create;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;100;-815.8124,217.1834;Float;False;Property;_noise_gen_2_param;noise_gen_2_param;9;0;Create;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;103;-835.8378,-52.16222;Float;False;Property;_noise_gen_1_offset;noise_gen_1_offset;8;0;Create;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector4Node;102;-837.8146,766.3434;Float;False;Property;_noise_gen_3_param;noise_gen_3_param;11;0;Create;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;105;-836.7621,941.415;Float;False;Property;_noise_gen_3_offset;noise_gen_3_offset;12;0;Create;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;104;-811.0114,383.5142;Float;False;Property;_noise_gen_2_offset;noise_gen_2_offset;10;0;Create;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.FunctionNode;95;-472.4709,-130.0464;Float;False;NoiseMap3D-InputControls;-1;;44;881603018fb00644bb72fdd1d8455841;5;23;FLOAT;3.0;False;22;FLOAT2;0.44,0.25;False;21;FLOAT;0.0;False;19;FLOAT;0.5;False;20;FLOAT;-0.25;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;96;-417.3722,205.187;Float;False;NoiseMap3D-InputControls;-1;;45;881603018fb00644bb72fdd1d8455841;5;23;FLOAT;5.0;False;22;FLOAT2;0,0;False;21;FLOAT;0.0;False;19;FLOAT;0.33;False;20;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;97;-457.7456,681.9241;Float;False;NoiseMap3D-InputControls;-1;;46;881603018fb00644bb72fdd1d8455841;5;23;FLOAT;8.0;False;22;FLOAT2;0,0;False;21;FLOAT;0.0;False;19;FLOAT;0.33;False;20;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;13;-1951.024,-134.7171;Float;False;908.2314;498.3652;Dissolve - Opacity Mask;5;19;17;16;15;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;76;-43.24124,-107.0827;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1876.584,-595.702;Float;False;814.5701;432.0292;Burn Effect - Emission;6;25;24;23;22;21;20;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;23;-1602.089,-443.8987;Float;True;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1268.336,-63.37055;Float;True;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;20;-1865.804,-371.9044;Float;True;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-4.0;False;4;FLOAT;4.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-1616.21,135.1488;Float;True;Property;_TextureSample1;Texture Sample 1;13;0;Create;None;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;26;-1306.726,-922.8453;Float;True;Property;_TextureSample3;Texture Sample 3;5;0;Create;None;7130c16fd8005b546b111d341310a9a4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-1232.815,-565.8346;Float;True;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;40;242.9852,26.03468;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;21;-1856.685,-588.2852;Float;True;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-1902.694,-62.50293;Float;False;Property;_Float2;Float 2;15;0;Create;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;17;-1469.082,-62.8725;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-0.6;False;4;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;37;-1270.225,447.3382;Float;True;Property;_dissolveguide;dissolve-guide;16;0;Create;e28dc97a9541e3642a48c0e3886688c5;e28dc97a9541e3642a48c0e3886688c5;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;27;-1309.353,-755.4795;Float;True;Property;_TextureSample4;Texture Sample 4;6;0;Create;None;11f03d9db1a617e40b7ece71f0a84f6f;True;0;True;bump;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;22;-1404.25,-569.6975;Float;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;15;-1638.899,-61.65704;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;-1405.795,-349.7877;Float;True;Property;_TextureSample2;Texture Sample 2;14;0;Create;None;64e7766099ad46747a07014e44d0aea1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;467.352,194.8733;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;My/Dissolve;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;True;2;16.9;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;95;23;98;1
WireConnection;95;22;103;0
WireConnection;95;21;98;2
WireConnection;95;19;98;3
WireConnection;95;20;98;4
WireConnection;96;23;100;1
WireConnection;96;22;104;0
WireConnection;96;21;100;2
WireConnection;96;19;100;3
WireConnection;96;20;100;4
WireConnection;97;23;102;1
WireConnection;97;22;105;0
WireConnection;97;21;102;2
WireConnection;97;19;102;3
WireConnection;97;20;102;4
WireConnection;76;0;95;0
WireConnection;76;1;96;0
WireConnection;76;2;97;0
WireConnection;23;0;22;0
WireConnection;19;0;17;0
WireConnection;19;1;16;1
WireConnection;20;0;19;0
WireConnection;25;0;22;0
WireConnection;25;1;24;0
WireConnection;40;0;76;0
WireConnection;40;1;76;0
WireConnection;40;2;76;0
WireConnection;21;0;20;0
WireConnection;17;0;15;0
WireConnection;22;0;21;0
WireConnection;15;0;14;0
WireConnection;24;1;23;0
WireConnection;0;2;40;0
ASEEND*/
//CHKSM=0153474ECDCB8A3496722F50B28C962336384A42