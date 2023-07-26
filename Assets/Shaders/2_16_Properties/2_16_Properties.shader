Shader "Custom/2_16_Properties" 
{
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Emission ("Emision (RGB)", 2D) = "white" {}
	}
	SubShader 
	{
		
		CGPROGRAM
		// [Type_of_shader] [Name_of_surf_func] [Lighting_model]
		#pragma surface surf Lambert 

		sampler2D _MainTex;
		sampler2D _Emission;

		struct Input {
			float2 uv_MainTex;
			float2 uv_Emission;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex);

			// Adding emission to a Material makes it appear
			// as a visible source of light in your Scene.
			//
			// The Material emission properties control the color
			// and intensity of light that the surface of a
			// Material emits.  Emission is useful when you want
			// some part of a GameObject to appear lit from the
			// inside.
			//
			// GameObjects that use emissive Materials appear to
			// remain bright even in dark areas of your Scene.
			o.Emission = tex2D(_Emission, IN.uv_Emission).rgb;
		}
		
		ENDCG
	}
	FallBack "Diffuse"
}