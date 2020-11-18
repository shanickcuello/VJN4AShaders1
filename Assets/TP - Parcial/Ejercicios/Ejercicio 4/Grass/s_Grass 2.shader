// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "s_Grass"
{
	Properties
	{
		_GrassTexture("Grass Texture", 2D) = "white" {}
		_MyPos("MyPos", Vector) = (0,0,0,0)
		_Offset("Offset", Vector) = (0,0,0,0)
		_Influency("Influency", Float) = 0
		_Float0("Float 0", Float) = 0
		_Float1("Float 1", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _Influency;
		uniform float _Float0;
		uniform float3 _MyPos;
		uniform float3 _Offset;
		uniform float _Float1;
		uniform sampler2D _GrassTexture;
		uniform float4 _GrassTexture_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float mulTime77 = _Time.y * 2.0;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 ase_vertexNormal = v.normal.xyz;
			float temp_output_25_0 = distance( ( _MyPos + _Offset ) , ase_worldPos );
			float3 temp_cast_0 = (( ( ( sin( mulTime77 ) * ( ase_worldPos.y * v.texcoord.xy ).y ) * ase_vertexNormal.y * _Influency ) + ( v.texcoord.xy.y /  ( _Float0 - _Float1 > temp_output_25_0 ? _Float1 : _Float0 - _Float1 <= temp_output_25_0 && _Float0 + _Float1 >= temp_output_25_0 ? _Float1 : temp_output_25_0 )  ) )).xxx;
			v.vertex.xyz += temp_cast_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_GrassTexture = i.uv_texcoord * _GrassTexture_ST.xy + _GrassTexture_ST.zw;
			float4 tex2DNode1 = tex2D( _GrassTexture, uv_GrassTexture );
			o.Albedo = tex2DNode1.rgb;
			o.Alpha = tex2DNode1.a;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
491;1065;1049;275;1401.665;-826.1198;1.641712;True;False
Node;AmplifyShaderEditor.CommentaryNode;53;-1117.674,954.4235;Inherit;False;499.9932;410.2519;Posición del jugador;2;26;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector3Node;24;-1218.209,973.7296;Inherit;False;Property;_MyPos;MyPos;1;0;Create;True;0;0;False;0;0,0,0;1.173178,-0.2658789,-2.193098;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;60;-1221.575,1121.532;Inherit;False;Property;_Offset;Offset;2;0;Create;True;0;0;False;0;0,0,0;0.09,2.23,-0.26;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;75;-2081.864,203.4794;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-2081.864,363.4795;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;78;-1777.864,171.4794;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;77;-1745.864,-100.5206;Inherit;False;1;0;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-880.2068,1055.876;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;26;-878.5394,1222.915;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;90;-408.9352,905.4189;Inherit;False;Property;_Float0;Float 0;4;0;Create;True;0;0;False;0;0;1.81;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-1040.52,706.7952;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;79;-1585.864,171.4794;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SinOpNode;80;-1521.864,-100.5206;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-420.4448,1171.092;Inherit;False;Property;_Float1;Float 1;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;25;-475.0557,1043.516;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCIf;89;-143.1047,966.2514;Inherit;False;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-1265.864,11.47942;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;83;-1175.763,252.4488;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;84;-1162.699,420.9335;Inherit;False;Property;_Influency;Influency;3;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;63;-784.5204,706.7952;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleDivideOpNode;66;-450.0459,706.0706;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-914.3233,90.93303;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;56;-757.1415,-225.9975;Inherit;False;371;280;Albedo y (A) Opacity;1;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;39;-299.1431,278.9116;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;95;-202.3129,406.6547;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-707.1415,-175.9975;Inherit;True;Property;_GrassTexture;Grass Texture;0;0;Create;True;0;0;False;0;-1;None;02444f569bf902b4fa4f534dcece049d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;s_Grass;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;78;0;75;2
WireConnection;78;1;76;0
WireConnection;61;0;24;0
WireConnection;61;1;60;0
WireConnection;79;0;78;0
WireConnection;80;0;77;0
WireConnection;25;0;61;0
WireConnection;25;1;26;0
WireConnection;89;0;90;0
WireConnection;89;1;25;0
WireConnection;89;2;91;0
WireConnection;89;3;91;0
WireConnection;89;4;25;0
WireConnection;89;5;91;0
WireConnection;81;0;80;0
WireConnection;81;1;79;1
WireConnection;63;0;62;0
WireConnection;66;0;63;1
WireConnection;66;1;89;0
WireConnection;82;0;81;0
WireConnection;82;1;83;2
WireConnection;82;2;84;0
WireConnection;95;0;82;0
WireConnection;95;1;66;0
WireConnection;0;0;1;0
WireConnection;0;9;1;4
WireConnection;0;11;95;0
ASEEND*/
//CHKSM=17AF819E16E0E4180D8DC5335D23AF1173250782