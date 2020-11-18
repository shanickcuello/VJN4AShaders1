// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Liquid"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 2
		_WaterJet("WaterJet", Float) = 2.46
		_Power("Power", Float) = 0
		_Random("Random", Float) = 0.26
		_Color0("Color 0", Color) = (0.1172414,1,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
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

		uniform float _Random;
		uniform float _Power;
		uniform float _WaterJet;
		uniform float4 _Color0;
		uniform float _EdgeLength;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		float4 tessFunction( appdata_full v0, appdata_full v1, appdata_full v2 )
		{
			return UnityEdgeLengthBasedTess (v0.vertex, v1.vertex, v2.vertex, _EdgeLength);
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float3 ase_vertexNormal = v.normal.xyz;
			float2 temp_cast_0 = (_Time.y).xx;
			float2 uv_TexCoord128 = v.texcoord.xy + temp_cast_0;
			float simplePerlin2D127 = snoise( uv_TexCoord128*_Random );
			simplePerlin2D127 = simplePerlin2D127*0.5 + 0.5;
			v.vertex.xyz += ( ( ase_vertexNormal * saturate( simplePerlin2D127 ) * _Power ) / _WaterJet );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_4_0_g4 = ase_worldNormal;
			float3 temp_output_14_0_g4 = cross( ddy( ase_worldPos ) , temp_output_4_0_g4 );
			float3 temp_output_9_0_g4 = ddx( ase_worldPos );
			float dotResult21_g4 = dot( temp_output_14_0_g4 , temp_output_9_0_g4 );
			float3 temp_output_1_0_g3 = float3( 0,0,0 );
			float3 temp_output_2_0_g3 = ddx( temp_output_1_0_g3 );
			float temp_output_2_0_g4 = temp_output_1_0_g3.x;
			float3 temp_output_7_0_g3 = ddy( temp_output_1_0_g3 );
			float ifLocalVar17_g4 = 0;
			if( dotResult21_g4 > 0.0 )
				ifLocalVar17_g4 = 1.0;
			else if( dotResult21_g4 == 0.0 )
				ifLocalVar17_g4 = 0.0;
			else if( dotResult21_g4 < 0.0 )
				ifLocalVar17_g4 = -1.0;
			float3 normalizeResult23_g4 = normalize( ( ( abs( dotResult21_g4 ) * temp_output_4_0_g4 ) - ( ( ( ( ( temp_output_1_0_g3 + temp_output_2_0_g3 ).x - temp_output_2_0_g4 ) * temp_output_14_0_g4 ) + ( ( ( temp_output_1_0_g3 + temp_output_7_0_g3 ).x - temp_output_2_0_g4 ) * cross( temp_output_4_0_g4 , temp_output_9_0_g4 ) ) ) * ifLocalVar17_g4 ) ) );
			o.Normal = normalizeResult23_g4;
			o.Albedo = _Color0.rgb;
			o.Smoothness = 1.0;
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
239;760;1049;368;-399.735;-301.9794;1.937621;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;129;955.9897,638.6158;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;1271.568,745.5779;Inherit;False;Property;_Random;Random;8;0;Create;True;0;0;False;0;0.26;2.59;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;128;1201.193,594.2427;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;127;1493.623,596.6509;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;130;2121.843,835.41;Inherit;False;Property;_Power;Power;7;0;Create;True;0;0;False;0;0;1.48;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;14;1838.03,670.3789;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;108;1845.01,468.7152;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;23;-1598.36,-386.6735;Inherit;False;886.677;758.8679;;6;2;9;1;4;74;75;Efecto de radio;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;22;1802.619,163.8176;Inherit;False;PreparePerturbNormalHQ;-1;;3;ce0790c3228f3654b818a19dd51453a4;0;1;1;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT3;4;FLOAT3;6;FLOAT;9
Node;AmplifyShaderEditor.CommentaryNode;24;-369.0165,-30.24972;Inherit;False;682.1265;352.7526;Previo al seno falta un calculo;4;7;8;119;120;Seno para repetirlo;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;2113.463,507.2569;Inherit;True;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;111;2349.237,857.5169;Inherit;False;Property;_WaterJet;WaterJet;5;0;Create;True;0;0;False;0;2.46;56.71;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;120;-302.7255,286.4109;Inherit;False;Property;_Float6;Float 6;6;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;21;2177.458,168.0222;Inherit;False;PerturbNormalHQ;-1;;4;45dff16e78a0685469fed8b5b46e4d96;0;4;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;18;1505.233,-68.58904;Float;False;Property;_Color0;Color 0;9;0;Create;True;0;0;False;0;0.1172414,1,0,0;0.1172413,1,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DistanceOpNode;2;-1223.847,142.0113;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-924.861,32.03585;Inherit;False;Constant;_Float3;Float 3;5;0;Create;True;0;0;False;0;4;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;75;-779.4927,40.61727;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;91;-577.2194,26.84716;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;4;-1532.402,30.80544;Float;False;Constant;_Vector0;Vector 0;0;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;119;-110.7164,65.77996;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;7;-319.0165,42.90237;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;125.9675,317.2732;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.79;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;9;-985.6477,169.437;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0.04;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1542.235,163.2961;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-1202.631,417.6777;Float;False;Property;_RingWidth;RingWidth;10;0;Create;True;0;0;False;0;-0.01;6.93;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;2368.345,348.5789;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;110;2404.788,535.3599;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2656.996,158.7549;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;Liquid;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;2;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;128;1;129;0
WireConnection;127;0;128;0
WireConnection;127;1;86;0
WireConnection;14;0;127;0
WireConnection;109;0;108;0
WireConnection;109;1;14;0
WireConnection;109;2;130;0
WireConnection;21;1;22;0
WireConnection;21;2;22;4
WireConnection;21;3;22;6
WireConnection;2;0;4;0
WireConnection;2;1;1;0
WireConnection;75;0;74;0
WireConnection;91;0;75;0
WireConnection;119;0;7;0
WireConnection;119;1;120;0
WireConnection;7;0;91;0
WireConnection;8;0;119;0
WireConnection;9;0;2;0
WireConnection;9;1;12;0
WireConnection;110;0;109;0
WireConnection;110;1;111;0
WireConnection;0;0;18;0
WireConnection;0;1;21;0
WireConnection;0;4;19;0
WireConnection;0;11;110;0
ASEEND*/
//CHKSM=7E35461DD0B1B4AA608361953B543D8C50B7D446