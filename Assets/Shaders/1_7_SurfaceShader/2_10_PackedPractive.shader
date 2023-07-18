Shader "Custom/2_10_PackedPractive" {
	Properties {
		_Color ("Example Color", Color) = (1,1,1,1)
	}
	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input
		{
			float2 uvMainTex;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb;
			// Since Albedo is a half3 (RGB), we can't assign the alpha chanel
			// directly. Instead, we have to use the Alpha property of SurfaceOutput.
			o.Alpha = _Color.a;

			// Remember that we can set all 3 properties of SurfaceOutput at once
			// or set just one; This will take just the red chanel from any color we
			// set on teh inspector :
			// o.Albedo.r = _Color.r;

			// We can use different channel packed arrays names from our SurfaceOutput
			// thanks to the fact that the elements in the _Color property ALWAYS used
			// fixed names [rgba | xyzw] where x = r, y = g, z = b, w = a :
			// o.Albedo.r = _Color.x;
			// o.Albedo.x = _Color.r;
			// o.Albedo.x = _Color.x;
			// o.Albedo.r = _Color.r;

			// Thanks to the previous statement about the packed arrays fixed names, we
			// can also do something like this, where the red chanel of my albedo is
			// set to the green chanel of my color :
			// o.Albedo = _Color.gbr;

			// But we can't mix names, we work using rgba or xyzw, not both :
			// o.Albedo = _Color.gxa;

			// We can use the same packed array names anywhere we want, but is good
			// practice to use the same names for the same things :
			// Colors / Textures => rgba
			// Coordinates / Position => xyzw
		}
		
		ENDCG
	}
	FallBack "Diffuse"
}