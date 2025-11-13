using System;
using System.Collections.Generic;
using avatar;
using UnityEngine;
using UnityEngine.InputSystem;
using Random = UnityEngine.Random;

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
        public JumpingAvatar avatar;
        public float autoReloadTime;

        private float reloadTime;

        private readonly List<GameObject> objects = new();

        void Start()
        {
            Reload();
        }


        void Update()
        {
            if(Input.GetKeyDown(KeyCode.R))
                Reload();
            
            if(autoReloadTime > 0 && Time.time > reloadTime + autoReloadTime)
                Reload();
        }

        private void Reload()
        {
            foreach (GameObject item in objects)
            {
                Destroy(item.gameObject);
            }
            reloadTime = Time.time;
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


        private void OnMouseDown()
        {
            Vector3 targetPos = GetMouseHit(LayerMask.GetMask("Ground"));
            avatar.JumpTo(targetPos);
        }


        private Vector3 GetMouseHit(LayerMask layerMask)
        {
            // Mausposition in Bildschirmkoordinaten
            Vector2 mousePos = Mouse.current.position.ReadValue();

            // Ray von Kamera durch Mausposition
            Ray ray = Camera.main.ScreenPointToRay(mousePos);

            if (Physics.Raycast(ray, out RaycastHit hit, Mathf.Infinity, layerMask))
            {
                // Objekt auf Treffpunkt verschieben
                return hit.point;
            }
            return Vector3.negativeInfinity;
        }
        
        
        
        
    }
}