// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "s_Sand2"
{
	Properties
	{
		_FallOff1("FallOff", Float) = 1
		_Frecuency1("Frecuency", Float) = 10
		_CircleSpeed1("CircleSpeed", Float) = -1
		_Radio1("Radio", Float) = 11.79
		_Texture1("Texture 0", 2D) = "white" {}
		_TextureSample1("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _Texture1;
		uniform float4 _Texture1_ST;
		uniform float _Frecuency1;
		uniform float _CircleSpeed1;
		uniform float _Radio1;
		uniform float _FallOff1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float4 color24 = IsGammaSpace() ? float4(0.1843137,0.7058824,0.7007753,1) : float4(0.02842603,0.4564111,0.4490934,1);
			float2 uv_Texture1 = i.uv_texcoord * _Texture1_ST.xy + _Texture1_ST.zw;
			float grayscale16_g29 = (tex2D( _Texture1, uv_Texture1 ).rgb.r + tex2D( _Texture1, uv_Texture1 ).rgb.g + tex2D( _Texture1, uv_Texture1 ).rgb.b) / 3;
			float mulTime4 = _Time.y * _CircleSpeed1;
			float3 ase_worldPos = i.worldPos;
			float4 lerpResult28 = lerp( tex2D( _TextureSample1, uv_TextureSample1 ) , color24 , saturate( ( ( 1.0 - (0.0 + (( 1.0 - grayscale16_g29 ) - 0.1) * (1.0 - 0.0) / (1.0 - 0.1)) ) * pow( ( ( sin( ( _Frecuency1 * ( mulTime4 + distance( float3(0,0,0) , ase_worldPos ) ) ) ) + 0.0 ) / _Radio1 ) , _FallOff1 ) ) ));
			o.Albedo = lerpResult28.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
486;482;1127;457;972.6847;440.2442;1.541533;True;False
Node;AmplifyShaderEditor.Vector3Node;1;-2321.671,495.1705;Inherit;False;Constant;_PointPosition1;PointPosition;0;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;2;-2305.671,271.1703;Inherit;False;Property;_CircleSpeed1;CircleSpeed;7;0;Create;True;0;0;False;0;-1;-2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;3;-2321.671,655.1702;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;4;-2113.671,335.1703;Inherit;False;1;0;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;5;-2097.671,463.1705;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1969.67,191.1703;Inherit;False;Property;_Frecuency1;Frecuency;6;0;Create;True;0;0;False;0;10;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-1921.67,383.1705;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1745.67,207.1704;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;9;-1473.671,303.1703;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1201.67,639.1702;Inherit;False;Property;_Radio1;Radio;8;0;Create;True;0;0;False;0;11.79;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-1233.67,351.1703;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;14;-884.577,89.19663;Inherit;True;Property;_Texture1;Texture 0;9;0;Create;True;0;0;False;0;ba0caa9df1b77b743b33e0e16966b5c4;ba0caa9df1b77b743b33e0e16966b5c4;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;12;-972.4011,349.3582;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-953.16,600.6352;Inherit;False;Property;_FallOff1;FallOff;0;0;Create;True;0;0;False;0;1;3.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;17;-635.4269,93.68153;Inherit;True;Scan;1;;29;a85fb4f0aad06a34790f8f2e23177195;0;2;38;FLOAT4;0,0,0,0;False;32;SAMPLER2D;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;18;-709.0818,443.7571;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-444.1106,437.5353;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;22;-222.8809,168.4758;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;24;-663.2744,-171.2757;Inherit;False;Constant;_Color1;Color 0;10;0;Create;True;0;0;False;0;0.1843137,0.7058824,0.7007753,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-517.5219,-385.3331;Inherit;True;Property;_TextureSample1;Texture Sample 0;10;0;Create;True;0;0;False;0;-1;6c589fcfdd0f5c54d949a7ee8e8686e9;6c589fcfdd0f5c54d949a7ee8e8686e9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;28;-376.1285,-89.80239;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;s_Sand2;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;2;0
WireConnection;5;0;1;0
WireConnection;5;1;3;0
WireConnection;7;0;4;0
WireConnection;7;1;5;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;9;0;8;0
WireConnection;11;0;9;0
WireConnection;12;0;11;0
WireConnection;12;1;10;0
WireConnection;17;32;14;0
WireConnection;18;0;12;0
WireConnection;18;1;13;0
WireConnection;19;0;17;0
WireConnection;19;1;18;0
WireConnection;22;0;19;0
WireConnection;28;0;23;0
WireConnection;28;1;24;0
WireConnection;28;2;22;0
WireConnection;0;0;28;0
ASEEND*/
//CHKSM=519BF265087964FB96205C38D786D2CECFE6F445