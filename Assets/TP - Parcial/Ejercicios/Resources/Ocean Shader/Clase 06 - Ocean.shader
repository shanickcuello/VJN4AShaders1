// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Clase 06 - Ocean"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 32
		_WaveColor("Wave Color", Color) = (0,0,0,0)
		_CrestColor("Crest Color", Color) = (0,0,0,0)
		_MicroNormalTiling("Micro Normal Tiling", Float) = 0
		_Float0("Float 0", Float) = 0
		_MicroNormalSpeed("Micro Normal Speed", Vector) = (0,0,0,0)
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		_MicroNormalMap("Micro Normal Map", 2D) = "bump" {}
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_MicroNormalScale("Micro Normal Scale", Range( 0 , 1)) = 0
		_Float1("Float 1", Range( 0 , 1)) = 0
		_Skybox("Skybox", CUBE) = "white" {}
		_NumberofWaves("Number of Waves", Float) = 0
		_Steepness("Steepness", Range( 0 , 1)) = 0
		_Wavelenght("Wavelenght", Float) = 0
		_Amplitude("Amplitude", Float) = 0
		_SpecularIntensity("Specular Intensity", Range( 0 , 1)) = 0
		_EmissiveIntensity("Emissive Intensity", Range( 0 , 1)) = 0
		_ShallowWaterOffsetIntensity("Shallow Water Offset Intensity", Range( 0 , 1)) = 0
		_Speed("Speed", Float) = 0
		_Direction1("Direction1", Vector) = (0,0,0,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Direction3("Direction3", Vector) = (0,0,0,0)
		_MainOpacity("Main Opacity", Range( 0 , 1)) = 0
		_NearOpacity("Near Opacity", Range( 0 , 1)) = 0
		_ShallowWaterOpacity("Shallow Water Opacity", Range( 0 , 1)) = 0
		_NormalDistortion("Normal Distortion", 2D) = "bump" {}
		_Scale("Scale", Float) = 0
		_VertexNormalIntensity("Vertex Normal Intensity", Range( 0 , 1)) = 0
		_Direction2("Direction2", Vector) = (0,0,0,0)
		_CrestOpacity("Crest Opacity", Range( 0 , 1)) = 0
		_Direction4("Direction4", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#pragma target 4.6
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf StandardSpecular alpha:fade keepalpha noshadow vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			INTERNAL_DATA
			float3 worldNormal;
			float4 screenPos;
		};

		uniform float _Steepness;
		uniform float _Wavelenght;
		uniform float _Amplitude;
		uniform float _NumberofWaves;
		uniform float3 _Direction1;
		uniform float _Speed;
		uniform float3 _Direction2;
		uniform float3 _Direction3;
		uniform float3 _Direction4;
		uniform float _ShallowWaterOffsetIntensity;
		uniform float _VertexNormalIntensity;
		uniform float _MicroNormalScale;
		uniform sampler2D _MicroNormalMap;
		uniform float2 _MicroNormalSpeed;
		uniform float _MicroNormalTiling;
		uniform float _Float1;
		uniform sampler2D _TextureSample0;
		uniform float2 _Vector0;
		uniform float _Float0;
		uniform float4 _WaveColor;
		uniform float4 _CrestColor;
		uniform samplerCUBE _Skybox;
		uniform float _EmissiveIntensity;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float _Scale;
		uniform sampler2D _NormalDistortion;
		uniform float4 _NormalDistortion_ST;
		uniform float _SpecularIntensity;
		uniform float _Smoothness;
		uniform float _ShallowWaterOpacity;
		uniform float _NearOpacity;
		uniform float _MainOpacity;
		uniform float _CrestOpacity;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _TessValue;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float temp_output_2_0_g22 = _Wavelenght;
			float w11_g22 = sqrt( ( ( 6.28318548202515 / temp_output_2_0_g22 ) * 9.81 ) );
			float temp_output_36_0_g22 = _Amplitude;
			float A43_g22 = temp_output_36_0_g22;
			float temp_output_44_0_g22 = ( ( _Steepness / ( ( w11_g22 * temp_output_36_0_g22 ) * _NumberofWaves ) ) * A43_g22 );
			float2 normalizeResult15_g22 = normalize( (_Direction1).xz );
			float2 break48_g22 = normalizeResult15_g22;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float dotResult18_g22 = dot( normalizeResult15_g22 , (ase_worldPos).xz );
			float temp_output_31_0_g22 = ( ( dotResult18_g22 * w11_g22 ) + ( ( ( 2.0 / temp_output_2_0_g22 ) * _Speed ) * _Time.y ) );
			float temp_output_50_0_g22 = cos( temp_output_31_0_g22 );
			float3 appendResult52_g22 = (float3(( temp_output_44_0_g22 * break48_g22.x * temp_output_50_0_g22 ) , ( sin( temp_output_31_0_g22 ) * A43_g22 ) , ( temp_output_44_0_g22 * break48_g22.y * temp_output_50_0_g22 )));
			float temp_output_2_0_g24 = _Wavelenght;
			float w11_g24 = sqrt( ( ( 6.28318548202515 / temp_output_2_0_g24 ) * 9.81 ) );
			float temp_output_36_0_g24 = _Amplitude;
			float A43_g24 = temp_output_36_0_g24;
			float temp_output_44_0_g24 = ( ( _Steepness / ( ( w11_g24 * temp_output_36_0_g24 ) * _NumberofWaves ) ) * A43_g24 );
			float2 normalizeResult15_g24 = normalize( (_Direction2).xz );
			float2 break48_g24 = normalizeResult15_g24;
			float dotResult18_g24 = dot( normalizeResult15_g24 , (ase_worldPos).xz );
			float temp_output_31_0_g24 = ( ( dotResult18_g24 * w11_g24 ) + ( ( ( 2.0 / temp_output_2_0_g24 ) * _Speed ) * _Time.y ) );
			float temp_output_50_0_g24 = cos( temp_output_31_0_g24 );
			float3 appendResult52_g24 = (float3(( temp_output_44_0_g24 * break48_g24.x * temp_output_50_0_g24 ) , ( sin( temp_output_31_0_g24 ) * A43_g24 ) , ( temp_output_44_0_g24 * break48_g24.y * temp_output_50_0_g24 )));
			float temp_output_2_0_g25 = _Wavelenght;
			float w11_g25 = sqrt( ( ( 6.28318548202515 / temp_output_2_0_g25 ) * 9.81 ) );
			float temp_output_65_0 = ( _Amplitude / 2.0 );
			float temp_output_36_0_g25 = temp_output_65_0;
			float A43_g25 = temp_output_36_0_g25;
			float temp_output_44_0_g25 = ( ( _Steepness / ( ( w11_g25 * temp_output_36_0_g25 ) * _NumberofWaves ) ) * A43_g25 );
			float2 normalizeResult15_g25 = normalize( (_Direction3).xz );
			float2 break48_g25 = normalizeResult15_g25;
			float dotResult18_g25 = dot( normalizeResult15_g25 , (ase_worldPos).xz );
			float temp_output_61_0 = ( _Speed * 3.0 );
			float temp_output_31_0_g25 = ( ( dotResult18_g25 * w11_g25 ) + ( ( ( 2.0 / temp_output_2_0_g25 ) * temp_output_61_0 ) * _Time.y ) );
			float temp_output_50_0_g25 = cos( temp_output_31_0_g25 );
			float3 appendResult52_g25 = (float3(( temp_output_44_0_g25 * break48_g25.x * temp_output_50_0_g25 ) , ( sin( temp_output_31_0_g25 ) * A43_g25 ) , ( temp_output_44_0_g25 * break48_g25.y * temp_output_50_0_g25 )));
			float temp_output_2_0_g23 = _Wavelenght;
			float w11_g23 = sqrt( ( ( 6.28318548202515 / temp_output_2_0_g23 ) * 9.81 ) );
			float temp_output_36_0_g23 = temp_output_65_0;
			float A43_g23 = temp_output_36_0_g23;
			float temp_output_44_0_g23 = ( ( _Steepness / ( ( w11_g23 * temp_output_36_0_g23 ) * _NumberofWaves ) ) * A43_g23 );
			float2 normalizeResult15_g23 = normalize( (_Direction4).xz );
			float2 break48_g23 = normalizeResult15_g23;
			float dotResult18_g23 = dot( normalizeResult15_g23 , (ase_worldPos).xz );
			float temp_output_31_0_g23 = ( ( dotResult18_g23 * w11_g23 ) + ( ( ( 2.0 / temp_output_2_0_g23 ) * temp_output_61_0 ) * _Time.y ) );
			float temp_output_50_0_g23 = cos( temp_output_31_0_g23 );
			float3 appendResult52_g23 = (float3(( temp_output_44_0_g23 * break48_g23.x * temp_output_50_0_g23 ) , ( sin( temp_output_31_0_g23 ) * A43_g23 ) , ( temp_output_44_0_g23 * break48_g23.y * temp_output_50_0_g23 )));
			float3 temp_output_66_0 = ( appendResult52_g22 + appendResult52_g24 + appendResult52_g25 + appendResult52_g23 );
			float3 lerpResult45 = lerp( temp_output_66_0 , ( temp_output_66_0 * _ShallowWaterOffsetIntensity ) , v.color.r);
			float3 LocalVertexOffset68 = lerpResult45;
			v.vertex.xyz += LocalVertexOffset68;
			float4 color95 = IsGammaSpace() ? float4(0,0,1,0) : float4(0,0,1,0);
			float4 lerpResult93 = lerp( float4( abs( temp_output_66_0 ) , 0.0 ) , color95 , _VertexNormalIntensity);
			float4 VertexNormal97 = lerpResult93;
			v.normal = VertexNormal97.rgb;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 temp_cast_0 = (_MicroNormalTiling).xx;
			float2 uv_TexCoord10 = i.uv_texcoord * temp_cast_0;
			float2 panner8 = ( 1.0 * _Time.y * _MicroNormalSpeed + uv_TexCoord10);
			float2 temp_cast_1 = (_Float0).xx;
			float2 uv_TexCoord15 = i.uv_texcoord * temp_cast_1;
			float2 panner18 = ( 1.0 * _Time.y * _Vector0 + uv_TexCoord15);
			float3 NormalMap23 = BlendNormals( UnpackScaleNormal( tex2D( _MicroNormalMap, panner8 ), _MicroNormalScale ) , UnpackScaleNormal( tex2D( _TextureSample0, panner18 ), _Float1 ) );
			o.Normal = NormalMap23;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 lerpResult4 = lerp( _WaveColor , _CrestColor , saturate( ase_vertex3Pos.y ));
			float4 Color6 = lerpResult4;
			o.Albedo = Color6.rgb;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_tangentToWorldFast = float3x3(ase_worldTangent.x,ase_worldBitangent.x,ase_worldNormal.x,ase_worldTangent.y,ase_worldBitangent.y,ase_worldNormal.y,ase_worldTangent.z,ase_worldBitangent.z,ase_worldNormal.z);
			float fresnelNdotV33 = dot( mul(ase_tangentToWorldFast,NormalMap23), ase_worldViewDir );
			float fresnelNode33 = ( 0.0 + 1.0 * pow( 1.0 - fresnelNdotV33, 5.0 ) );
			float4 texCUBENode29 = texCUBE( _Skybox, reflect( -ase_worldViewDir , ase_worldNormal ) );
			float4 Emission39 = ( ( saturate( fresnelNode33 ) * texCUBENode29 ) * _EmissiveIntensity );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float2 uv_NormalDistortion = i.uv_texcoord * _NormalDistortion_ST.xy + _NormalDistortion_ST.zw;
			float4 screenColor100 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( ase_grabScreenPosNorm + float4( UnpackScaleNormal( tex2D( _NormalDistortion, uv_NormalDistortion ), _Scale ) , 0.0 ) ).xy);
			o.Emission = ( Emission39 + screenColor100 ).rgb;
			float4 Specular32 = ( texCUBENode29 * _SpecularIntensity );
			o.Specular = Specular32.rgb;
			o.Smoothness = _Smoothness;
			float lerpResult77 = lerp( _MainOpacity , _CrestOpacity , saturate( ase_vertex3Pos.y ));
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float3 ase_viewPos = UnityObjectToViewPos( ase_vertex4Pos );
			float ase_screenDepth = -ase_viewPos.z;
			float cameraDepthFade83 = (( ase_screenDepth -_ProjectionParams.y - 0.0 ) / 1.0);
			float lerpResult81 = lerp( _NearOpacity , lerpResult77 , saturate( cameraDepthFade83 ));
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth86 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth86 = abs( ( screenDepth86 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( 1.0 ) );
			float lerpResult85 = lerp( _ShallowWaterOpacity , lerpResult81 , saturate( distanceDepth86 ));
			float Opacity89 = lerpResult85;
			o.Alpha = Opacity89;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
20;452;1352;626;502.8212;-1766.508;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;24;-2703.445,542.2704;Inherit;False;2118.645;881.9829;;4;22;21;20;23;Normal Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;21;-2649.746,1029.248;Inherit;False;1353.088;395.0052;Macro Normal;6;15;17;18;19;16;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;22;-2653.445,592.2703;Inherit;False;1351.088;370.9642;Micro Normal;6;9;10;12;8;13;11;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-2599.746,1123.611;Inherit;False;Property;_Float0;Float 0;8;0;Create;True;0;0;False;0;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-2603.445,687.6324;Inherit;False;Property;_MicroNormalTiling;Micro Normal Tiling;7;0;Create;True;0;0;False;0;0;9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;16;-2333.73,1263.253;Inherit;False;Property;_Vector0;Vector 0;10;0;Create;True;0;0;False;0;0,0;-0.05,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-2343.445,668.6325;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-2337.746,1105.611;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;11;-2339.428,802.2345;Inherit;False;Property;_MicroNormalSpeed;Micro Normal Speed;9;0;Create;True;0;0;False;0;0,0;-0.14,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;13;-1966.357,831.2703;Inherit;False;Property;_MicroNormalScale;Micro Normal Scale;13;0;Create;True;0;0;False;0;0;0.37;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;8;-1930.857,672.2068;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1960.658,1268.248;Inherit;False;Property;_Float1;Float 1;14;0;Create;True;0;0;False;0;0;0.44;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;18;-1925.158,1109.185;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;17;-1616.658,1079.248;Inherit;True;Property;_TextureSample0;Texture Sample 0;12;0;Create;True;0;0;False;0;-1;None;ffd205f3aed07b94d92c2b5d32d3e50f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-1622.358,642.2703;Inherit;True;Property;_MicroNormalMap;Micro Normal Map;11;0;Create;True;0;0;False;0;-1;None;9995ced1ceddd1c43b5bd1311da3db78;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;20;-1131.139,906.514;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;41;-2639.403,1885.545;Inherit;False;1617.359;376.3599;;8;26;27;28;29;31;25;30;32;Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-827.8,902.3446;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;40;-2326.396,1547.768;Inherit;False;1567;279;;7;33;34;35;36;37;38;39;Emissive;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;25;-2589.403,1962.35;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;69;-2870.526,2726.645;Inherit;False;1747.583;1509.656;;16;57;58;56;51;62;53;61;54;55;60;63;64;65;52;59;66;Gerstner Wave;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-2673.204,2776.645;Inherit;False;Property;_Amplitude;Amplitude;19;0;Create;True;0;0;False;0;0;0.16;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-2695.903,3309.139;Inherit;False;Property;_Speed;Speed;23;0;Create;True;0;0;False;0;0;1.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;34;-2276.396,1600.768;Inherit;False;23;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;90;-2912.827,4599.286;Inherit;False;2202.787;597.7954;;14;83;82;78;77;75;76;79;81;84;86;87;85;88;89;Opacity;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;28;-2396.889,2082.905;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NegateNode;26;-2353.313,1966.919;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;64;-2709.005,4052.301;Inherit;False;Property;_Direction4;Direction4;35;0;Create;True;0;0;False;0;0,0,0;0.4587605,0,-0.8885603;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;55;-2768.798,3174.345;Inherit;False;Property;_NumberofWaves;Number of Waves;16;0;Create;True;0;0;False;0;0;24;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;57;-2724.553,3433.056;Inherit;False;Property;_Direction1;Direction1;24;0;Create;True;0;0;False;0;0,0,0;0.9603037,0,-0.2789569;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;63;-2705.297,3838.461;Inherit;False;Property;_Direction3;Direction3;26;0;Create;True;0;0;False;0;0,0,0;0.9966612,0,0.08164889;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;54;-2820.526,3033.093;Inherit;False;Property;_Steepness;Steepness;17;0;Create;True;0;0;False;0;0;0.135;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;78;-2862.827,5018.082;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-2347.154,3850.178;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-2748.12,2906.634;Inherit;False;Property;_Wavelenght;Wavelenght;18;0;Create;True;0;0;False;0;0;3.91;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ReflectOpNode;27;-2155.889,1966.905;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;33;-2037.396,1606.768;Inherit;False;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;65;-2311.652,3633.023;Inherit;False;2;0;FLOAT;2;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;62;-2707.769,3646.872;Inherit;False;Property;_Direction2;Direction2;33;0;Create;True;0;0;False;0;0,0,0;0.958068,0,-0.2865415;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;46;-889.5079,3251.754;Inherit;False;1161.889;372.4364;;6;68;67;43;44;45;42;Vertex Offset;1,1,1,1;0;0
Node;AmplifyShaderEditor.CameraDepthFade;83;-2286.092,4963.304;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;60;-1922.307,3719.125;Inherit;False;Gerstner Wave;-1;;23;5edb81d896e91d04b967c9c23d445fb7;0;6;36;FLOAT;0;False;2;FLOAT;0;False;32;FLOAT;0;False;40;FLOAT;0;False;26;FLOAT;0;False;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;58;-1914.557,3235.366;Inherit;False;Gerstner Wave;-1;;24;5edb81d896e91d04b967c9c23d445fb7;0;6;36;FLOAT;0;False;2;FLOAT;0;False;32;FLOAT;0;False;40;FLOAT;0;False;26;FLOAT;0;False;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;59;-1916.357,3477.221;Inherit;False;Gerstner Wave;-1;;25;5edb81d896e91d04b967c9c23d445fb7;0;6;36;FLOAT;0;False;2;FLOAT;0;False;32;FLOAT;0;False;40;FLOAT;0;False;26;FLOAT;0;False;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;7;-2684.52,-260.4864;Inherit;False;962.8311;646.4457;;6;1;2;4;3;5;6;Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;35;-1747.396,1604.768;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;79;-2559.627,5063.214;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;51;-1918.475,2980.451;Inherit;False;Gerstner Wave;-1;;22;5edb81d896e91d04b967c9c23d445fb7;0;6;36;FLOAT;0;False;2;FLOAT;0;False;32;FLOAT;0;False;40;FLOAT;0;False;26;FLOAT;0;False;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-2780.161,4773.887;Inherit;False;Property;_MainOpacity;Main Opacity;27;0;Create;True;0;0;False;0;0;0.494;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-1905.89,1937.905;Inherit;True;Property;_Skybox;Skybox;15;0;Create;True;0;0;False;0;-1;None;8ac6331dd1f46cc4ca57d30fa96d7042;True;0;False;white;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;76;-2778.332,4895.838;Inherit;False;Property;_CrestOpacity;Crest Opacity;34;0;Create;True;0;0;False;0;0;0.583;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-844.4699,3418.309;Inherit;False;Property;_ShallowWaterOffsetIntensity;Shallow Water Offset Intensity;22;0;Create;True;0;0;False;0;0;0.204;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;84;-1999.092,4961.304;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;3;-2619.224,206.9595;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;82;-2344.092,4652.304;Inherit;False;Property;_NearOpacity;Near Opacity;28;0;Create;True;0;0;False;0;0;0.672;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;66;-1277.943,3327.689;Inherit;False;4;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DepthFade;86;-1697.238,4955.286;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;98;-891.8849,2729.324;Inherit;False;919.8676;443.0869;;5;93;92;95;96;97;Vertex Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-1554.396,1719.768;Inherit;False;Property;_EmissiveIntensity;Emissive Intensity;21;0;Create;True;0;0;False;0;0;0.407577;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;77;-2386.268,4780.002;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1536.396,1604.768;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-94.3812,1873.635;Inherit;False;Property;_Scale;Scale;31;0;Create;True;0;0;False;0;0;0.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-499.8044,3340.83;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;87;-1407.238,4953.286;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;92;-799.4947,2791.257;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;67;-427.4482,3291.584;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;5;-2379.124,252.8918;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;81;-1808.095,4751.504;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;2;-2633.841,16.96632;Inherit;False;Property;_CrestColor;Crest Color;6;0;Create;True;0;0;False;0;0,0,0,0;0.1686275,0.572549,0.5647059,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;-2634.52,-210.4862;Inherit;False;Property;_WaveColor;Wave Color;5;0;Create;True;0;0;False;0;0,0,0,0;0.1294118,0.3411765,0.4823529,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;96;-818.8849,3058.411;Inherit;False;Property;_VertexNormalIntensity;Vertex Normal Intensity;32;0;Create;True;0;0;False;0;0;0.993;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;95;-797.5252,2871.052;Inherit;False;Constant;_Color0;Color 0;29;0;Create;True;0;0;False;0;0,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;42;-499.4671,3456.177;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;31;-1841.156,2143.655;Inherit;False;Property;_SpecularIntensity;Specular Intensity;20;0;Create;True;0;0;False;0;0;0.09411765;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1199.396,1603.768;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GrabScreenPosition;101;167.4052,1587.043;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;102;175.8173,1825.754;Inherit;True;Property;_NormalDistortion;Normal Distortion;30;0;Create;True;0;0;False;0;-1;None;ffd205f3aed07b94d92c2b5d32d3e50f;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;88;-1621.238,4650.286;Inherit;False;Property;_ShallowWaterOpacity;Shallow Water Opacity;29;0;Create;True;0;0;False;0;0;0.59;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;103;572.8408,1682.499;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;45;-244.1496,3316.64;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;85;-1208.591,4718.431;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-1460.023,1941.591;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;4;-2182.868,-12.26333;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;39;-1002.396,1597.768;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;93;-477.5634,2789.44;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;97;-215.0174,2779.324;Inherit;False;VertexNormal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-1265.045,1935.545;Inherit;False;Specular;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;89;-953.04,4712.297;Inherit;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;538.7162,847.9523;Inherit;False;39;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;6;-1964.688,-18.17548;Inherit;False;Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScreenColorNode;100;817.6475,1672.659;Inherit;False;Global;_GrabScreen0;Grab Screen 0;30;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-5.036908,3312.615;Inherit;False;LocalVertexOffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;106;937.7631,1090.962;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;91;575.2114,1208.243;Inherit;False;89;Opacity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;524.9567,1061.867;Inherit;False;Property;_Smoothness;Smoothness;25;0;Create;True;0;0;False;0;0;0.934869;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;556.3206,944.7577;Inherit;False;32;Specular;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;549.7162,688.9523;Inherit;False;6;Color;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;543.7162,767.9523;Inherit;False;23;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;99;571.9578,1421.396;Inherit;False;97;VertexNormal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;80;561.1883,1304.558;Inherit;False;68;LocalVertexOffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1161.642,887.158;Float;False;True;-1;6;ASEMaterialInspector;0;0;StandardSpecular;Clase 06 - Ocean;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;32;10;25;False;5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;0;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;9;0
WireConnection;15;0;14;0
WireConnection;8;0;10;0
WireConnection;8;2;11;0
WireConnection;18;0;15;0
WireConnection;18;2;16;0
WireConnection;17;1;18;0
WireConnection;17;5;19;0
WireConnection;12;1;8;0
WireConnection;12;5;13;0
WireConnection;20;0;12;0
WireConnection;20;1;17;0
WireConnection;23;0;20;0
WireConnection;26;0;25;0
WireConnection;61;0;56;0
WireConnection;27;0;26;0
WireConnection;27;1;28;0
WireConnection;33;0;34;0
WireConnection;65;0;52;0
WireConnection;60;36;65;0
WireConnection;60;2;53;0
WireConnection;60;32;54;0
WireConnection;60;40;55;0
WireConnection;60;26;61;0
WireConnection;60;13;64;0
WireConnection;58;36;52;0
WireConnection;58;2;53;0
WireConnection;58;32;54;0
WireConnection;58;40;55;0
WireConnection;58;26;56;0
WireConnection;58;13;62;0
WireConnection;59;36;65;0
WireConnection;59;2;53;0
WireConnection;59;32;54;0
WireConnection;59;40;55;0
WireConnection;59;26;61;0
WireConnection;59;13;63;0
WireConnection;35;0;33;0
WireConnection;79;0;78;2
WireConnection;51;36;52;0
WireConnection;51;2;53;0
WireConnection;51;32;54;0
WireConnection;51;40;55;0
WireConnection;51;26;56;0
WireConnection;51;13;57;0
WireConnection;29;1;27;0
WireConnection;84;0;83;0
WireConnection;66;0;51;0
WireConnection;66;1;58;0
WireConnection;66;2;59;0
WireConnection;66;3;60;0
WireConnection;77;0;75;0
WireConnection;77;1;76;0
WireConnection;77;2;79;0
WireConnection;36;0;35;0
WireConnection;36;1;29;0
WireConnection;44;0;66;0
WireConnection;44;1;43;0
WireConnection;87;0;86;0
WireConnection;92;0;66;0
WireConnection;67;0;66;0
WireConnection;5;0;3;2
WireConnection;81;0;82;0
WireConnection;81;1;77;0
WireConnection;81;2;84;0
WireConnection;38;0;36;0
WireConnection;38;1;37;0
WireConnection;102;5;105;0
WireConnection;103;0;101;0
WireConnection;103;1;102;0
WireConnection;45;0;67;0
WireConnection;45;1;44;0
WireConnection;45;2;42;1
WireConnection;85;0;88;0
WireConnection;85;1;81;0
WireConnection;85;2;87;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;4;0;1;0
WireConnection;4;1;2;0
WireConnection;4;2;5;0
WireConnection;39;0;38;0
WireConnection;93;0;92;0
WireConnection;93;1;95;0
WireConnection;93;2;96;0
WireConnection;97;0;93;0
WireConnection;32;0;30;0
WireConnection;89;0;85;0
WireConnection;6;0;4;0
WireConnection;100;0;103;0
WireConnection;68;0;45;0
WireConnection;106;0;72;0
WireConnection;106;1;100;0
WireConnection;0;0;70;0
WireConnection;0;1;71;0
WireConnection;0;2;106;0
WireConnection;0;3;73;0
WireConnection;0;4;74;0
WireConnection;0;9;91;0
WireConnection;0;11;80;0
WireConnection;0;12;99;0
ASEEND*/
//CHKSM=8CC3590CFCF884509BD4B56D45D4D6FEF3287EF1