Shader "Custom/2_12_ShaderProperties" 
{
	Properties 
	{
		_Color ("Example Color", Color) = (1,1,1,1)
		_Range ("Ecample Range", Range(0, 10)) = 1
		_MainTex ("Example Albedo (RGB)", 2D) = "white" {}
		_Cube ("Example Cube", CUBE) = "" {}
		_Float ("Example Float", Float) = 1
		_Vector ("Example Vector", Vector) = (1,1,1,1)
	}
	SubShader 
	{	
		// Here starts my shader code	
		CGPROGRAM

		// [Type_of_shader] [Name_of_surf_func] [Lighting_model]
		#pragma surface surf Lambert

		// This are the data type associated with my properties
		fixed4 _Color;
		float _Range;
		sampler2D _MainTex;
		samplerCUBE _Cube;
		float _Float;
		float4 _Vector;

		// Input values to use into my surface shader
		struct Input {
			// For UVS we NEED to follow the next naming convention
			// [uv]|[uv2][Name_of_property]
			// [uv][_MainTex]
			float2 uv_MainTex;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			// This is how we map the texture property into the Albedo chanel
			//o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;

			// We can multiply the albedo chanel using the range property
			// this could increase the intensity of the color far more than 255
			// resulting in a "burning"color image
			//o.Albedo *= _Range;

			// We can multiply the color with the main texture and the range value
			//o.Albedo = (_Color * tex2D(_MainTex, IN.uv_MainTex)).rgb * _Range;

			// Also, we can force the green chanel of the texture to full
			//o.Albedo = (_Color * tex2D(_MainTex, IN.uv_MainTex)).rgb * _Range;
			//o.Albedo.g = 1;

			// We can even multiply the texture color with a green color to force
			// the green chanel in the same calculation
			// o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb * float4(0,1,0,1);
			
			// Apply the cube map using the world reflection vector
			// and apply that information to the model emission chanel
			o.Emission = texCUBE(_Cube, IN.worldRefl).rgb;
		}

		// Here ends my shader code
		ENDCG
	}
	FallBack "Diffuse"
}