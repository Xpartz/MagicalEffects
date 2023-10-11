float arcLengthToAngle_half(float angle, float _Pitch) {
                        float radical = sqrt(angle * angle + 1.0f);
                        
                        return _Pitch * 0.5f * (angle * radical + log(angle + radical));
                    }


void RollLib_half(float3 Vert, float3 Norm, float StartAngle, float AnglePerUnit, float UnrolledAngle, float2 uv, float Pitch, out float3 VertOut) {

          float fromStart = Vert.z * AnglePerUnit;

                float fromOrigin = StartAngle - fromStart;
                float lengthToHere = arcLengthToAngle_half(fromOrigin,Pitch);
                float lengthToStart = arcLengthToAngle_half(StartAngle,Pitch);

                 uv.x = lengthToStart - lengthToHere;

                 
                if (fromStart < UnrolledAngle) {
                            float lengthToSplit = arcLengthToAngle_half(StartAngle - UnrolledAngle,Pitch);
                            Vert.z = lengthToSplit - lengthToHere;
                            Vert.y = 0.0f;
                            //v.normal = float3(0, 1, 0);
                        }
                        else {
                            float radiusAtSplit = Pitch * (StartAngle - UnrolledAngle);
                            float radius = Pitch * fromOrigin;

                            float shifted = fromStart - UnrolledAngle;

                            Vert.y = radiusAtSplit - cos(shifted) * radius;
                            Vert.z = sin(shifted) * radius;

                            //v.normal = float3(0, cos(shifted), -sin(shifted));
                        }

            //float _Pitch = arcLengthToAngle_half;
	VertOut = Vert;
}