// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "s_CausticWater"
{
	Properties
	{
		_SandTexture("Sand Texture", 2D) = "white" {}
		_FoamIntensity1("FoamIntensity", Float) = 0
		_VoroScale1("VoroScale", Float) = 2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _SandTexture;
		uniform float4 _SandTexture_ST;
		uniform float _VoroScale1;
		uniform float _FoamIntensity1;


		float2 voronoihash178( float2 p )
		{
			
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}


		float voronoi178( float2 v, float time, inout float2 id, float smoothness )
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
			 		float2 o = voronoihash178( n + g );
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


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_SandTexture = i.uv_texcoord * _SandTexture_ST.xy + _SandTexture_ST.zw;
			o.Albedo = tex2D( _SandTexture, uv_SandTexture ).rgb;
			float time178 = ( _Time.y * 0.31 );
			float2 coords178 = i.uv_texcoord * _VoroScale1;
			float2 id178 = 0;
			float voroi178 = voronoi178( coords178, time178,id178, 0 );
			float3 temp_cast_1 = (( voroi178 / _FoamIntensity1 )).xxx;
			o.Emission = temp_cast_1;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
679;468;1127;469;205.8185;-736.8741;2.764227;True;False
Node;AmplifyShaderEditor.RangedFloatNode;174;855.076,1619.972;Inherit;False;Constant;_FoamSpeed1;FoamSpeed;10;0;Create;True;0;0;False;0;0.31;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;175;841.076,1547.972;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;176;1092.373,1697.473;Inherit;False;Property;_VoroScale1;VoroScale;4;0;Create;True;0;0;False;0;2;-3.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;177;1067.076,1558.972;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;160;1350.368,840.3955;Inherit;False;637.724;280;Normal Map;2;101;102;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;159;1432.866,1171.767;Inherit;False;546.4999;276.1;Albedo/Emission. Puede usarse en cualquiera de los dos;1;73;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;179;1476.923,1835.22;Inherit;False;Property;_FoamIntensity1;FoamIntensity;3;0;Create;True;0;0;False;0;0;4.11;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VoronoiNode;178;1344.204,1557.016;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT;1
Node;AmplifyShaderEditor.RangedFloatNode;102;1400.368,935.0015;Inherit;False;Property;_SandNormalScale;Sand Normal Scale;2;0;Create;True;0;0;False;0;0;1.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;101;1668.092,890.3955;Inherit;True;Property;_SandNormalMap;Sand Normal Map;1;0;Create;True;0;0;False;0;-1;None;b8871b68f91c5424585b474e9a8734db;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;73;1563.754,1230.754;Inherit;True;Property;_SandTexture;Sand Texture;0;0;Create;True;0;0;False;0;-1;None;6c589fcfdd0f5c54d949a7ee8e8686e9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;180;1691.932,1640.585;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;1.83;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2190.587,1407.616;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;s_CausticWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;177;0;175;0
WireConnection;177;1;174;0
WireConnection;178;1;177;0
WireConnection;178;2;176;0
WireConnection;101;5;102;0
WireConnection;180;0;178;0
WireConnection;180;1;179;0
WireConnection;0;0;73;0
WireConnection;0;2;180;0
ASEEND*/
//CHKSM=6A85FB85B04C0DE3578E45404D0F1BB2D3D43C0F