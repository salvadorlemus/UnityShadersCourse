Shader "Custom/2_12_ShaderProperties" {
	Properties {
		_Color ("Example Color", Color) = (1,1,1,1)
		_Range ("Ecample Range", Range(0, 10)) = 1
		_MainTex ("Example Albedo (RGB)", 2D) = "white" {}
		_Cube ("Example Cube", CUBE) = "" {}
		_Float ("Example Float", Float) = 1
		_Vector ("Example Vector", Vector) = (1,1,1,1)
	}
	SubShader {	
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

		void surf (Input IN, inout SurfaceOutput o) {
			// This is how we map the texture property into the Albedo chanel
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;

			// We can multiply the albedo chanel using the range property
			o.Albedo *= _Range;
			
			// Apply the cube map using the world reflection vector
			// and apply that information to the model emission chanel
			o.Emission = texCUBE(_Cube, IN.worldRefl).rgb;
		}

		// Here ends my shader code
		ENDCG
	}
	FallBack "Diffuse"
}