// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "s_Sand"
{
	Properties
	{
		_EdgeLength ( "Edge length", Range( 2, 50 ) ) = 15
		_FoamIntensity("FoamIntensity", Float) = 0.8
		_VoroScale("VoroScale", Float) = 2
		_FallOff("FallOff", Float) = 1
		_Frecuency("Frecuency", Float) = 10
		_CircleSpeed("CircleSpeed", Float) = -1
		_Radio("Radio", Float) = 11.79
		_Texture0("Texture 0", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "Tessellation.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float _Frecuency;
		uniform float _CircleSpeed;
		uniform float _Radio;
		uniform float _FallOff;
		uniform float _VoroScale;
		uniform float _FoamIntensity;
		uniform float _EdgeLength;


		float2 voronoihash126( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi126( float2 v, float time, inout float2 id, float smoothness )
		{
			float2 n = floor( v );
			float2 f = frac( v );
			float F1 = 8.0;
			float F2 = 8.0; float2 mr = 0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash126( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = g - f + o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
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
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 color78 = IsGammaSpace() ? float4(0.1843137,0.7058824,0.7007753,1) : float4(0.02842603,0.4564111,0.4490934,1);
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float grayscale16_g29 = (tex2D( _Texture0, uv_Texture0 ).rgb.r + tex2D( _Texture0, uv_Texture0 ).rgb.g + tex2D( _Texture0, uv_Texture0 ).rgb.b) / 3;
			float mulTime109 = _Time.y * _CircleSpeed;
			float3 ase_worldPos = i.worldPos;
			float temp_output_84_0 = saturate( ( ( 1.0 - (0.0 + (( 1.0 - grayscale16_g29 ) - 0.1) * (1.0 - 0.0) / (1.0 - 0.1)) ) * pow( ( ( sin( ( _Frecuency * ( mulTime109 + distance( float3(0,0,0) , ase_worldPos ) ) ) ) + 0.0 ) / _Radio ) , _FallOff ) ) );
			float4 lerpResult18 = lerp( tex2D( _TextureSample0, uv_TextureSample0 ) , color78 , temp_output_84_0);
			o.Albedo = lerpResult18.rgb;
			float time126 = ( _Time.y * 1.43 );
			float2 coords126 = i.uv_texcoord * _VoroScale;
			float2 id126 = 0;
			float voroi126 = voronoi126( coords126, time126,id126, 0 );
			float3 temp_cast_2 = (( voroi126 / _FoamIntensity )).xxx;
			o.Emission = temp_cast_2;
			o.Alpha = temp_output_84_0;
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
				vertexDataFunc( v );
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
145;271;1283;653;4396.315;1817.642;6.120512;False;False
Node;AmplifyShaderEditor.WorldPosInputsNode;108;-2715.246,835.6801;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;110;-2715.246,675.6801;Inherit;False;Constant;_PointPosition;PointPosition;0;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;106;-2699.246,451.68;Inherit;False;Property;_CircleSpeed;CircleSpeed;14;0;Create;True;0;0;False;0;-1;-2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;109;-2507.246,515.6801;Inherit;False;1;0;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;107;-2491.246,643.6801;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;103;-2315.246,563.6801;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;-2363.246,371.68;Inherit;False;Property;_Frecuency;Frecuency;13;0;Create;True;0;0;False;0;10;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;102;-1989.262,540.9253;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;100;-1697.699,508.1342;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;115;-1535.952,515.3776;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;101;-1389.833,840.8736;Inherit;False;Property;_Radio;Radio;15;0;Create;True;0;0;False;0;11.79;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;73;-1618.45,171.9528;Inherit;True;Property;_Texture0;Texture 0;16;0;Create;True;0;0;False;0;ba0caa9df1b77b743b33e0e16966b5c4;ba0caa9df1b77b743b33e0e16966b5c4;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-1154.724,836.5881;Inherit;False;Property;_FallOff;FallOff;7;0;Create;True;0;0;False;0;1;3.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;105;-1325.599,523.5286;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;99;-952.0542,588.3125;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;120;-1146.803,227.6004;Inherit;True;Scan;8;;29;a85fb4f0aad06a34790f8f2e23177195;0;2;38;FLOAT4;0,0,0,0;False;32;SAMPLER2D;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;121;-810.452,-740.2275;Inherit;False;Constant;_FoamSpeed;FoamSpeed;10;0;Create;True;0;0;False;0;1.43;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;122;-824.452,-812.2274;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-598.4518,-801.2272;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-573.155,-662.7266;Inherit;False;Property;_VoroScale;VoroScale;6;0;Create;True;0;0;False;0;2;13.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;104;-687.0832,582.0907;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;84;-363.9512,356.1684;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;78;-266.4305,129.5457;Inherit;False;Constant;_Color0;Color 0;10;0;Create;True;0;0;False;0;0.1843137,0.7058824,0.7007753,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-348.0244,-76.09142;Inherit;True;Property;_TextureSample0;Texture Sample 0;18;0;Create;True;0;0;False;0;-1;6c589fcfdd0f5c54d949a7ee8e8686e9;6c589fcfdd0f5c54d949a7ee8e8686e9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;126;-321.3243,-803.1833;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.RangedFloatNode;125;-188.6052,-524.9794;Inherit;False;Property;_FoamIntensity;FoamIntensity;5;0;Create;True;0;0;False;0;0.8;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;127;38.55846,-777.9576;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1.83;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;20.71556,211.0188;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;912.479,84.4886;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;s_Sand;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;5;True;True;0;True;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;2;15;10;25;False;5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;17;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;109;0;106;0
WireConnection;107;0;110;0
WireConnection;107;1;108;0
WireConnection;103;0;109;0
WireConnection;103;1;107;0
WireConnection;102;0;97;0
WireConnection;102;1;103;0
WireConnection;100;0;102;0
WireConnection;115;0;100;0
WireConnection;105;0;115;0
WireConnection;105;1;101;0
WireConnection;99;0;105;0
WireConnection;99;1;98;0
WireConnection;120;32;73;0
WireConnection;124;0;122;0
WireConnection;124;1;121;0
WireConnection;104;0;120;0
WireConnection;104;1;99;0
WireConnection;84;0;104;0
WireConnection;126;1;124;0
WireConnection;126;2;123;0
WireConnection;127;0;126;0
WireConnection;127;1;125;0
WireConnection;18;0;1;0
WireConnection;18;1;78;0
WireConnection;18;2;84;0
WireConnection;0;0;18;0
WireConnection;0;2;127;0
WireConnection;0;9;84;0
ASEEND*/
//CHKSM=D3FC20D4AA598DCC3BB42F4A141141F2A2E02923