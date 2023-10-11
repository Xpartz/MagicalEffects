Shader "Custom/ColorShader"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _StartAngle("Start Angle (Radians)", float) = 60.0
        _AnglePerUnit("Radians per Unit", float) = 0.2
        _Pitch("Pitch", float) = 0.02
        _UnrolledAngle("Unrolled Angle", float) = 1.5
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        Cull Off
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                   float2 uv : TEXCOORD0;
            };

            struct v2f
            {
               float2 uv : TEXCOORD0;
               float4 vertex : SV_POSITION;
            };

            fixed4 _Color;
            float _StartAngle;
            float _AnglePerUnit;
            float _Pitch;
            float _UnrolledAngle;

             float arcLengthToAngle(float angle) {
            float radical = sqrt(angle * angle + 1.0f);
            return _Pitch * 0.5f * (angle * radical + log(angle + radical));
        }

           v2f vert (appdata_t v) {
                v2f o;
                float fromStart = v.vertex.z * _AnglePerUnit;

                float fromOrigin = _StartAngle - fromStart;
                float lengthToHere = arcLengthToAngle(fromOrigin);
                float lengthToStart = arcLengthToAngle(_StartAngle);

                o.uv.y = lengthToStart - lengthToHere;
    

                if (fromStart < _UnrolledAngle) {
                            float lengthToSplit = arcLengthToAngle(_StartAngle - _UnrolledAngle);
                            v.vertex.z = lengthToSplit - lengthToHere;
                            v.vertex.y = 0.0f;
                            //v.normal = float3(0, 1, 0);
                        }
                        else {
                            float radiusAtSplit = _Pitch * (_StartAngle - _UnrolledAngle);
                            float radius = _Pitch * fromOrigin;

                            float shifted = fromStart - _UnrolledAngle;

                            v.vertex.y = radiusAtSplit - cos(shifted) * radius;
                            v.vertex.z = sin(shifted) * radius;

                            //v.normal = float3(0, cos(shifted), -sin(shifted));
                        }


                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
    
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return _Color;
            }
            ENDCG
        }
    }
}
