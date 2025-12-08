using System;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace stoneCrush
{
    public class Menu : MonoBehaviour
    {
        
        
        public void NewGame()
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().name);
        }
    }
}