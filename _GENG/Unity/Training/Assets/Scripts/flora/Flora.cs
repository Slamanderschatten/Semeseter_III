using System.Collections.Generic;
using UnityEngine;

namespace flora
{
    public class Flora : MonoBehaviour
    {

        public GameObject ground;
        public GameObject[] prefabs;
        public int instanceCount;
        public float scaleMin;
        public float scaleMax;
        public float groundScaleMultiplier;

        private readonly List<GameObject> objects = new();

        void Start()
        {
            Reload();
        }


        void Update()
        {
            if(Input.GetKeyDown(KeyCode.R))
                Reload();
        }

        private void Reload()
        {
            float sizeX = ground.transform.localScale.x * groundScaleMultiplier;
            float sizeZ = ground.transform.localScale.z * groundScaleMultiplier;
            if (instanceCount < 1)
                instanceCount = 1;
            for(int i = 0; i < instanceCount; i++)
            {
                int prefabIndex = Random.Range(0, prefabs.Length);
                float scale = Random.Range(scaleMin, scaleMax);
                
                float xPos = Random.Range(0, sizeX);
                float zPos = Random.Range(0, sizeZ);

                GameObject obj = Instantiate(prefabs[prefabIndex], ground.transform);
                obj.transform.localPosition = new Vector3(xPos - sizeX/2, 0, zPos - sizeZ/2);
                obj.transform.localScale = new Vector3(scale, scale, scale);
                objects.Add(obj);
            }
        }
    }
}