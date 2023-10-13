using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class DisplayNormals : MonoBehaviour
{
    public Color normalColor = Color.blue;
    public float normalLength = 0.1f;
    public bool displayNormals = true; // Чекбокс для активации/деактивации отображения нормалей

    private void OnDrawGizmos()
    {
        if (!displayNormals)
            return;

        MeshFilter meshFilter = GetComponent<MeshFilter>();

        if (meshFilter != null && meshFilter.sharedMesh != null)
        {
            Mesh mesh = meshFilter.sharedMesh;
            Vector3[] vertices = mesh.vertices;
            Vector3[] normals = mesh.normals;

            Gizmos.color = normalColor;

            for (int i = 0; i < vertices.Length; i++)
            {
                Vector3 vertex = transform.TransformPoint(vertices[i]);
                Vector3 normal = transform.TransformDirection(normals[i]);

                Gizmos.DrawRay(vertex, normal * normalLength);
            }
        }
    }
}
