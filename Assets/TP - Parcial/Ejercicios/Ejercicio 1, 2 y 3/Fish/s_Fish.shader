// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "s_Fish"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_NumberMovement("NumberMovement", Float) = 0
		_Lenght("Lenght", Float) = 0
		_Float3("Float 3", Float) = 1
		_Float0("Float 0", Float) = 10
		_Float1("Float 1", Float) = -1
		_Float2("Float 2", Float) = 11.79
		_Texture0("Texture 0", 2D) = "white" {}
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
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _NumberMovement;
		uniform float _Lenght;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Texture0;
		uniform float4 _Texture0_ST;
		uniform float _Float0;
		uniform float _Float1;
		uniform float _Float2;
		uniform float _Float3;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float temp_output_2_0_g30 = _NumberMovement;
			float w11_g30 = sqrt( ( ( 6.28318548202515 / temp_output_2_0_g30 ) * 9.81 ) );
			float temp_output_36_0_g30 = _Lenght;
			float A43_g30 = temp_output_36_0_g30;
			float temp_output_44_0_g30 = ( ( 1.0 / ( ( w11_g30 * temp_output_36_0_g30 ) * 3.0 ) ) * A43_g30 );
			float2 normalizeResult15_g30 = normalize( (float3(1,0,0)).xz );
			float2 break48_g30 = normalizeResult15_g30;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float dotResult18_g30 = dot( normalizeResult15_g30 , (ase_worldPos).xz );
			float temp_output_31_0_g30 = ( ( dotResult18_g30 * w11_g30 ) + ( ( ( 2.0 / temp_output_2_0_g30 ) * 10.0 ) * _Time.y ) );
			float temp_output_50_0_g30 = cos( temp_output_31_0_g30 );
			float3 appendResult52_g30 = (float3(( temp_output_44_0_g30 * break48_g30.x * temp_output_50_0_g30 ) , ( sin( temp_output_31_0_g30 ) * A43_g30 ) , ( temp_output_44_0_g30 * break48_g30.y * temp_output_50_0_g30 )));
			float3 temp_output_54_0 = appendResult52_g30;
			float3 appendResult8 = (float3(0.0 , 0.0 , temp_output_54_0.x));
			v.vertex.xyz += appendResult8;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 color83 = IsGammaSpace() ? float4(1,0.9833598,0.4669811,1) : float4(1,0.9625626,0.184742,1);
			float2 uv_Texture0 = i.uv_texcoord * _Texture0_ST.xy + _Texture0_ST.zw;
			float grayscale16_g29 = (tex2D( _Texture0, uv_Texture0 ).rgb.r + tex2D( _Texture0, uv_Texture0 ).rgb.g + tex2D( _Texture0, uv_Texture0 ).rgb.b) / 3;
			float mulTime71 = _Time.y * _Float1;
			float3 ase_worldPos = i.worldPos;
			float4 lerpResult84 = lerp( tex2D( _Albedo, uv_Albedo ) , color83 , saturate( ( ( 1.0 - (0.0 + (( 1.0 - grayscale16_g29 ) - 0.1) * (1.0 - 0.0) / (1.0 - 0.1)) ) * pow( ( ( sin( ( _Float0 * ( mulTime71 + distance( float3(0,0,0) , ase_worldPos ) ) ) ) + 0.0 ) / _Float2 ) , _Float3 ) ) ));
			o.Albedo = lerpResult84.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17800
448;257;1049;559;907.4894;-161.1678;1;True;False
Node;AmplifyShaderEditor.Vector3Node;68;-2824.147,104.0688;Inherit;False;Constant;_Vector1;Vector 1;0;0;Create;True;0;0;False;0;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;69;-2808.147,-119.9311;Inherit;False;Property;_Float1;Float 1;10;0;Create;True;0;0;False;0;-1;-2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;70;-2824.147,264.0687;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleTimeNode;71;-2616.147,-55.93121;Inherit;False;1;0;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;72;-2600.147,72.06876;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;73;-2424.147,-7.931218;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-2472.147,-199.9312;Inherit;False;Property;_Float0;Float 0;9;0;Create;True;0;0;False;0;10;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-2248.148,-183.9312;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;76;-1976.147,-87.93124;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-1736.147,-39.93122;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-1704.147,248.0687;Inherit;False;Property;_Float2;Float 2;11;0;Create;True;0;0;False;0;11.79;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;-1455.636,209.5336;Inherit;False;Property;_Float3;Float 3;3;0;Create;True;0;0;False;0;1;3.52;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;80;-1474.877,-41.74344;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;81;-1387.052,-301.9048;Inherit;True;Property;_Texture0;Texture 0;12;0;Create;True;0;0;False;0;None;ba0caa9df1b77b743b33e0e16966b5c4;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;65;-1137.903,-297.4199;Inherit;True;Scan;4;;29;a85fb4f0aad06a34790f8f2e23177195;0;2;38;FLOAT4;0,0,0,0;False;32;SAMPLER2D;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;64;-1211.558,52.65556;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;40;-400.3628,-394.056;Inherit;False;371;280;Albedo;1;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;66;-946.5861,46.43367;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-464.9049,588.7885;Inherit;False;Constant;_WaveCount;WaveCount;4;0;Create;True;0;0;False;0;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-632.5309,686.994;Inherit;False;Constant;_FishSpeed;FishSpeed;4;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-840.4419,453.0015;Inherit;False;Property;_NumberMovement;NumberMovement;1;0;Create;True;0;0;False;0;0;6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;59;-812.3975,351.296;Inherit;False;Property;_Lenght;Lenght;2;0;Create;True;0;0;False;0;0;1000;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;62;-824.2499,610.1309;Inherit;False;Constant;_Vector0;Vector 0;4;0;Create;True;0;0;False;0;1,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;57;-863.5685,532.0119;Inherit;False;Constant;_Amplitud;Amplitud;2;0;Create;True;0;0;False;0;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;54;-534.7627,377.5734;Inherit;False;Gerstner Wave;-1;;30;5edb81d896e91d04b967c9c23d445fb7;0;6;36;FLOAT;0;False;2;FLOAT;0;False;32;FLOAT;0;False;40;FLOAT;1;False;26;FLOAT;0;False;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;67;-717.6537,97.54355;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-350.3627,-344.0561;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;False;0;-1;None;3dff5d532d2a7564b926496ff66de545;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;39;-555.3628,889.7565;Inherit;False;554.5038;206;Mask;2;9;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;83;-617.7075,-110.7627;Inherit;False;Constant;_Color0;Color 0;10;0;Create;True;0;0;False;0;1,0.9833598,0.4669811,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;8;-148.2463,274.5579;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;85;-147.4894,458.1678;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;84;-255.638,-42.93496;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;12;-228.529,956.6066;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-505.3628,939.7567;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;33.71194,14.98309;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;s_Fish;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;71;0;69;0
WireConnection;72;0;68;0
WireConnection;72;1;70;0
WireConnection;73;0;71;0
WireConnection;73;1;72;0
WireConnection;75;0;74;0
WireConnection;75;1;73;0
WireConnection;76;0;75;0
WireConnection;77;0;76;0
WireConnection;80;0;77;0
WireConnection;80;1;78;0
WireConnection;65;32;81;0
WireConnection;64;0;80;0
WireConnection;64;1;79;0
WireConnection;66;0;65;0
WireConnection;66;1;64;0
WireConnection;54;36;59;0
WireConnection;54;2;58;0
WireConnection;54;32;57;0
WireConnection;54;40;63;0
WireConnection;54;26;60;0
WireConnection;54;13;62;0
WireConnection;67;0;66;0
WireConnection;8;2;54;0
WireConnection;85;0;54;0
WireConnection;84;0;1;0
WireConnection;84;1;83;0
WireConnection;84;2;67;0
WireConnection;12;0;9;1
WireConnection;0;0;84;0
WireConnection;0;11;8;0
ASEEND*/
//CHKSM=66D7DD079810A4EFEB7565EEAB16E11CAF7B17B5