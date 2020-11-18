// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Liquid2"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 32
		_Smoothness("Smoothness", Float) = 9.2
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_Color1("Color 1", Color) = (1,0.7028302,0.7028302,0.3294118)
		_Float3("Float 3", Float) = 2
		_Float5("Float 0", Float) = 10
		_Float4("Float 1", Float) = -1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float _Float5;
		uniform float _Float4;
		uniform float _Float3;
		uniform float3 _Vector0;
		uniform float4 _Color1;
		uniform float _Smoothness;
		uniform float _TessValue;

		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float mulTime66 = _Time.y * _Float4;
			float3 objToWorld90 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float temp_output_72_0 = ( sin( ( _Float5 * ( mulTime66 + distance( objToWorld90 , ase_worldPos ) ) ) ) + _Float3 );
			v.vertex.xyz += ( ( ase_vertexNormal * ( 1.0 - temp_output_72_0 ) ) / _Vector0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_4_0_g8 = ase_worldNormal;
			float3 temp_output_14_0_g8 = cross( ddy( ase_worldPos ) , temp_output_4_0_g8 );
			float3 temp_output_9_0_g8 = ddx( ase_worldPos );
			float dotResult21_g8 = dot( temp_output_14_0_g8 , temp_output_9_0_g8 );
			float mulTime66 = _Time.y * _Float4;
			float3 objToWorld90 = mul( unity_ObjectToWorld, float4( float3( 0,0,0 ), 1 ) ).xyz;
			float temp_output_72_0 = ( sin( ( _Float5 * ( mulTime66 + distance( objToWorld90 , ase_worldPos ) ) ) ) + _Float3 );
			float3 temp_output_1_0_g7 = ( _Color1 * temp_output_72_0 ).rgb;
			float3 temp_output_2_0_g7 = ddx( temp_output_1_0_g7 );
			float temp_output_2_0_g8 = temp_output_1_0_g7.x;
			float3 temp_output_7_0_g7 = ddy( temp_output_1_0_g7 );
			float ifLocalVar17_g8 = 0;
			if( dotResult21_g8 > 0.0 )
				ifLocalVar17_g8 = 1.0;
			else if( dotResult21_g8 == 0.0 )
				ifLocalVar17_g8 = 0.0;
			else if( dotResult21_g8 < 0.0 )
				ifLocalVar17_g8 = -1.0;
			float3 normalizeResult23_g8 = normalize( ( ( abs( dotResult21_g8 ) * temp_output_4_0_g8 ) - ( ( ( ( ( temp_output_1_0_g7 + temp_output_2_0_g7 ).x - temp_output_2_0_g8 ) * temp_output_14_0_g8 ) + ( ( ( temp_output_1_0_g7 + temp_output_7_0_g7 ).x - temp_output_2_0_g8 ) * cross( temp_output_4_0_g8 , temp_output_9_0_g8 ) ) ) * ifLocalVar17_g8 ) ) );
			o.Normal = normalizeResult23_g8;
			o.Albedo = float4(0.1172414,1,0,0).rgb;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
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
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
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
436;485;1283;653;294.3705;-125.9194;1;False;False
Node;AmplifyShaderEditor.WorldPosInputsNode;65;-478.9164,956.6509;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;64;-405.9163,521.6512;Inherit;False;Property;_Float4;Float 1;10;0;Create;True;0;0;False;0;-1;-1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TransformPositionNode;90;-547.1987,758.6704;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;66;-270.9162,636.6509;Inherit;False;1;0;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;67;-254.9162,764.6508;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-78.91617,684.6509;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-126.9162,492.6509;Inherit;False;Property;_Float5;Float 0;9;0;Create;True;0;0;False;0;10;9.88;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;97.08294,731.3414;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;71;360.8408,559.4308;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;422.0478,787.3362;Inherit;False;Property;_Float3;Float 3;8;0;Create;True;0;0;False;0;2;1.38;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;72;571.1824,531.6957;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;102;-151.0313,225.3039;Inherit;False;Property;_Color1;Color 1;7;0;Create;True;0;0;False;0;1,0.7028302,0.7028302,0.3294118;0.2924528,0.2924528,0.2924528,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;148.8071,257.0797;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;88;840.6396,540.8016;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;84;1069.671,396.4527;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;50;459.3071,89.96135;Inherit;False;889.7726;229.1687;Generar Normal Map;2;39;38;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;38;509.3069,139.9614;Inherit;False;PreparePerturbNormalHQ;-1;;7;ce0790c3228f3654b818a19dd51453a4;0;1;1;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT3;4;FLOAT3;6;FLOAT;9
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;1284.845,487.2344;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;93;1168.637,642.2;Inherit;False;Property;_Vector0;Vector 0;6;0;Create;True;0;0;False;0;0,0,0;4.38,97.9,19.7;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;15;1361.437,360.3844;Float;False;Property;_Smoothness;Smoothness;5;0;Create;True;0;0;False;0;9.2;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;1140.228,-119.7251;Float;False;Constant;_Color0;Color 0;3;0;Create;True;0;0;False;0;0.1172414,1,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;91;1447.512,481.8076;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;39;899.0794,140.1301;Inherit;False;PerturbNormalHQ;-1;;8;45dff16e78a0685469fed8b5b46e4d96;0;4;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1669.348,101.5899;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Liquid2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;32;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;66;0;64;0
WireConnection;67;0;90;0
WireConnection;67;1;65;0
WireConnection;68;0;66;0
WireConnection;68;1;67;0
WireConnection;70;0;69;0
WireConnection;70;1;68;0
WireConnection;71;0;70;0
WireConnection;72;0;71;0
WireConnection;72;1;86;0
WireConnection;101;0;102;0
WireConnection;101;1;72;0
WireConnection;88;0;72;0
WireConnection;38;1;101;0
WireConnection;85;0;84;0
WireConnection;85;1;88;0
WireConnection;91;0;85;0
WireConnection;91;1;93;0
WireConnection;39;1;38;0
WireConnection;39;2;38;4
WireConnection;39;3;38;6
WireConnection;0;0;8;0
WireConnection;0;1;39;0
WireConnection;0;4;15;0
WireConnection;0;11;91;0
ASEEND*/
//CHKSM=9001CE7BA06137E3C2FEEA994037112A23E20531