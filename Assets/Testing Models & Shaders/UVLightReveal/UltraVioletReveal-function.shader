// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "My/UltraVioletLightReveal-Function"
{
	Properties
	{
		_Emmission("Emmission", 2D) = "white" {}
		[Header(UVLightRevealFunction)]
		_UVReveal("UV Reveal", 2D) = "white" {}
		_DifferenceThreshold("Difference Threshold", Range( 0 , 0.05)) = 0.0191
		_Intensity("Intensity", Float) = 1
		_Colortobefiltered("Color to be filtered", Color) = (0.4039216,0,1,1)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _Intensity;
		uniform sampler2D _UVReveal;
		uniform float4 _UVReveal_ST;
		uniform float4 _Colortobefiltered;
		uniform float _DifferenceThreshold;
		uniform sampler2D _Emmission;
		uniform float4 _Emmission_ST;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#if DIRECTIONAL
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			float2 uv_UVReveal = i.uv_texcoord * _UVReveal_ST.xy + _UVReveal_ST.zw;
			float3 normalizeResult31_g4 = normalize( (( _LightColor0 * _WorldSpaceLightPos0.w )).rgb );
			float3 normalizeResult11_g4 = normalize( (_Colortobefiltered).rgb );
			float dotResult26_g4 = dot( normalizeResult31_g4 , normalizeResult11_g4 );
			float2 uv_Emmission = i.uv_texcoord * _Emmission_ST.xy + _Emmission_ST.zw;
			c.rgb = ( ( _Intensity * tex2D( _UVReveal, uv_UVReveal ).r * ( ( ase_lightAtten * _LightColor0 * _WorldSpaceLightPos0.w ) *  ( dotResult26_g4 - _DifferenceThreshold > 1.0 ? 0.0 : dotResult26_g4 - _DifferenceThreshold <= 1.0 && dotResult26_g4 + _DifferenceThreshold >= 1.0 ? 1.0 : 0.0 )  ) ) + tex2D( _Emmission, uv_Emmission ) ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
2130;24;1379;830;1324.717;595.0137;1.3;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-482.8068,-28.46305;Float;True;Property;_Emmission;Emmission;3;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;9;-872.3167,-97.11379;Float;True;UVLightRevealFunction;4;;4;51bee7bd659cf82439424b9af4a188dc;0;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;6;-74.11668,-101.0137;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-463.3502,-514.465;Float;True;Property;_Albedo;Albedo;1;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-467.7593,-257.8043;Float;True;Property;_Normal;Normal;2;0;Create;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-478.6285,183.628;Float;True;Property;_Specular;Specular;0;0;Create;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;202,-163;Float;False;True;2;Float;ASEMaterialInspector;0;0;CustomLighting;My/UltraVioletLightReveal-Function;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0.0,0,0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;9;0
WireConnection;6;1;1;0
WireConnection;0;13;6;0
ASEEND*/
//CHKSM=89846234A52057FB08C2677E1DA1A74E4884264F