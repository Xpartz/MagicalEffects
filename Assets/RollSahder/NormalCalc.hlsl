float arcLengthToAngleNormal_half(float angle, float _Pitch) {
                        float radical = sqrt(angle * angle + 1.0f);
                        
                        return _Pitch * 0.5f * (angle * radical + log(angle + radical));
                    }


void NormalCalcF_half(float3 Vert, float3 Norm, float StartAngle, float AnglePerUnit, float UnrolledAngle, float2 uv, float Pitch, out float3 NormalOut) {

          float fromStart =   Vert.z * AnglePerUnit;

                float fromOrigin = StartAngle - fromStart;
                float lengthToHere = arcLengthToAngleNormal_half(fromOrigin,Pitch);
                float lengthToStart = arcLengthToAngleNormal_half(StartAngle,Pitch);

                 uv.x = lengthToStart - lengthToHere;

                 
                if (fromStart < UnrolledAngle) {
                            float lengthToSplit = arcLengthToAngleNormal_half(StartAngle - UnrolledAngle,Pitch);
                            Vert.z = lengthToSplit - lengthToHere;
                            Vert.y = Vert.y;
                           NormalOut = Norm;
                        }
                        else {
                            float radiusAtSplit = Pitch * (StartAngle - UnrolledAngle);
                            float radius = Pitch * fromOrigin;

                            float shifted = fromStart - UnrolledAngle;

                            Vert.y = Vert.y + (radiusAtSplit - cos(shifted) * radius);
                            Vert.z += sin(shifted) * radius;

                            NormalOut = float3(Norm.x, Norm.y + cos(shifted),Norm.z + sin(shifted));
                        }

            //float _Pitch = arcLengthToAngle_half;
	
}