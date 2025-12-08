using System;
using Unity.VisualScripting;
using UnityEngine;
using Random = UnityEngine.Random;

namespace stoneCrush
{
    public class Stone : MonoBehaviour
    {
        public Library lib;
        public SpriteRenderer rend;


        private void Start()
        {
            if(lib == null)
                lib = FindObjectsByType<Library>(FindObjectsSortMode.None)[0].GetComponent<Library>();
            
            int randSymbolIndex = Random.Range(0, lib.symbols.Length);
            int randColorIndex = Random.Range(0, lib.colors.Length);
            
            rend.sprite = lib.symbols[randSymbolIndex];
            rend.color = lib.colors[randColorIndex];
        }


        private void OnMouseDown()
        {
            gameObject.AddComponent<Destroyer>();
        }
    }
}