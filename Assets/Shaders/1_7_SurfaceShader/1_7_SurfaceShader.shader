// Surface Shader; this ;ine tells Unity where to locate my shader and it's name
// In this case it will live inside Course under the name of 1_7_SurfaceShader 
Shader "Course/1_7_SurfaceShader"
{
    // Properties are where we declare variables that can be set inside Unity
    // and used inside my shader processing 
    Properties
    {
        // In my shader I should refer to this property as "_myColour"
        // The name of the property inside Unity will be "Example Color"
        // The default value will be white
        _Color ("Example Color", Color) = (1,1,1,1)
        _Emission ("Example Emission", Color) = (0,0,0,1)
        _Normal ("Example Normal", Color) = (0,0,0,1)
    }
    
    // SubShader is where we define what to do with our shader on different
    //  graphics cards and with all properties, geometry and lightning we need
    SubShader
    {
        // The code starts here with the tag : 
        CGPROGRAM

            // #pragma is a compile directive telling Unity how we want our shader to be
            // use, in this case is telling Unity to use the surface word, which means
            // we are creating a surface shader, surf is the name of the function that
            // contains our surface shader code and Lambert is the lightning model we
            // want to use
            #pragma surface surf Lambert

            // This struct tells Unity what are the required data for our surface shader
            // ehis can include vertex data, lightning data, textures, etc.
            struct Input
            {
                float2 uvMainTex;
            };

            // To acces the property we created we need to declare a variable of the same
            // type and name as the property, but with an underscore at the beginning
            fixed4 _Color;
            fixed4 _Emission;
            fixed4 _Normal;   

            // This is the function that contains our surface shader code.
            // The input variable contains all the data we declared in the struct Input
            // The output variable contains all the data we need to send to the pixel
            // shader, in this case we are only sending the albedo color
            // The output depends of the lightning model we are using
            void surf (Input IN, inout SurfaceOutput o)
            {
                // Here I set the Albedo porperty from my SurfaceOutput into the
                // value of the property I created
                o.Albedo = _Color.rgb;
                o.Emission = _Emission.rgb;
                o.Normal = _Normal.rgb;
            }

        // The code ends here with the tag : 
        ENDCG
    }
    
    // Use for inferiors graphics cards
    FallBack "Diffuse"
}
