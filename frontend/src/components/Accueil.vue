<template>
  <v-app id="forum" class="forum">
    <top-header />
    <div class="ml-12">
      <h1 class="ma-4">Bienvenue sur le Forum de Groupomania</h1>

      <!--ajouter un post-->
      <router-view></router-view>
      <v-container>
        <v-btn
          class="ma-3"
          color="red darken-2 white--text"
          @click="afficheForm"
        >
          Créer un post
        </v-btn>

        <v-card
          class="forum__post ma-3 mt-6"
          v-for="(post, index) in allPosts"
          v-bind:key="index"
        >
          <div class="d-flex justify-space-between">
            <v-card-title>
              <h2 class="forum__post__title ml-0">{{ post.title }}</h2>
            </v-card-title>

            <v-card-actions
              class="forum__post__manage"
              v-if="post.userId == userId"
            >
              <!--modifier mon post-->

              <v-btn
                class="forum__post__manage--btn"
                color="black"
                title="modifier le post"
                @click.stop="goDialogUpPost(post.title, post.content, post.id)"
                icon
              >
                <v-icon>mdi-pencil</v-icon>
              </v-btn>

              <!--supprimer mon post-->

              <v-btn
                class="forum__post__manage--btn"
                color="black"
                title="supprimer le post"
                @click="deletePost(post.id)"
                icon
              >
                <v-icon>mdi-delete</v-icon>
              </v-btn>
            </v-card-actions>
          </div>
          <img v-if="post.img" :src="post.img" alt="" class="imgPost" />
          <!--mon post-->

          <v-card-subtitle class="forum__post__name">
            Par {{ post.firstName }} {{ post.lastName }}, le {{ post.date }} à
            {{ post.time }}
          </v-card-subtitle>

          <v-card-text class="v-card-text black--text forum__post__content">
            {{ post.content }}
          </v-card-text>

          <!--like-->

          <v-card-text class="py-0">
            <!--bouton commentaires-->

            <v-btn
              text
              @click="afficheCom(post.id)"
              title="Voir les commentaires"
            >
              <v-icon>mdi-comment-eye</v-icon> Voir les commentaires
            </v-btn>
          </v-card-text>

          <!--Modifier mon post-->

          <v-dialog v-model="dialogUpPost" max-width="500px">
            <v-card>
              <v-card-title>Modifier mon post</v-card-title>

              <v-card-text>
                <v-form ref="form" v-model="valid">
                  <v-text-field
                    v-model="dataPost.title"
                    color="black"
                    :rules="titreRegle"
                    :counter="50"
                    label="Titre"
                  ></v-text-field>

                  <v-textarea
                    v-model="dataPost.content"
                    color="black"
                    :rules="contentRules"
                    label="Commentaire"
                  ></v-textarea>
                </v-form>
              </v-card-text>

              <v-card-actions>
                <v-btn text @click="dialogUpPost = false">Annuler</v-btn>

                <v-btn text :disabled="!valid" @click="updatePost()">
                  Valider
                </v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>

          <!--afficher les commentaires-->

          <div class="forum__comments" v-if="postId === post.id">
            <v-card
              class="forum__comments--ind my-1 mx-2 pa-3"
              color="#ECECEC"
              v-for="(comment, index) in allComments"
              v-bind:key="index"
              outlined
            >
              <v-card-subtitle class="pa-0 forum__comments__name">
                Le {{ comment.date }}, {{ comment.firstName }}
                {{ comment.lastName }} commente :
              </v-card-subtitle>

              <v-card-text class="pa-0 text--primary forum__comments__content">
                {{ comment.comContent }}
              </v-card-text>

              <v-dialog v-model="dialogUpCom" max-width="500px">
                <v-card>
                  <v-card-title>Modifier mon commentaire</v-card-title>

                  <v-card-text>
                    <v-form ref="form" v-model="valid">
                      <v-textarea
                        v-model="dataCom.content"
                        color="black"
                        :rules="commenterPostRegle"
                        :counter="255"
                        label="Commentaire"
                      ></v-textarea>
                    </v-form>
                  </v-card-text>

                  <v-card-actions>
                    <v-btn text @click="dialogUpCom = false">Annuler</v-btn>

                    <v-btn text :disabled="!valid" @click="updateCom()">
                      Valider
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </v-card>

            <!--Commenter le post-->

            <v-btn
              v-if="!commenterPost"
              color="black white--text"
              title="commenter le post"
              class="ma-2"
              @click="afficheCommenterPost()"
            >
              Commenter
            </v-btn>

            <v-card v-if="commenterPost">
              <v-form ref="form" class="ma-3" v-model="valid">
                <v-textarea
                  background-color="#ECECEC"
                  color="black"
                  v-model="dataCom.content"
                  :rules="commenterPostRegle"
                  :counter="255"
                  label="Commentaire"
                  autofocus
                  required
                ></v-textarea>
              </v-form>

              <v-btn
                :disabled="!valid"
                class="success ma-2"
                @click="sendCom(post.id)"
              >
                Poster
              </v-btn>
            </v-card>
          </div>
        </v-card>
      </v-container>
    </div>
  </v-app>
</template>

<script>
// eslint-disable-next-line
/* eslint-disable */
import TopHeader from "./Accueil/TopHeader";
import axios from "axios";
export default {
  name: "forum",
  data() {
    return {
      userId: "",
      admin: "",
      commenterPost: false,
      allPosts: [],
      allComments: [],
      postId: "",
      dialogUpCom: false,
      dialogUpPost: false,
      valid: true,
      titreRegle: [
        (v) => !!v || "Titre de la publication",
        (v) =>
          (v && v.length <= 50) || "Le titre doit faire moins de 50 caractères",
      ],
      contentRules: [(v) => !!v || "Ecrivez votre message"],
      commenterPostRegle: [
        (v) => !!v || "Ecrivez votre commentaire",
        (v) =>
          (v && v.length <= 255) ||
          "Le commentaire doit faire moins de 255 caractères",
      ],
      dataPost: {
        id: "",
        title: "",
        content: "",
        userId: "",
      },
      dataPostS: "",
      dataCom: {
        id: "",
        content: "",
        userId: "",
      },
    };
  },
  methods: {
    afficheCom(pId) {
      this.postId = pId;
      this.commenterPost = false;
      axios
        .get("http://localhost:3000/api/posts/" + pId + "/comments", {
          headers: { Authorization: "Bearer " + localStorage.token },
        })
        .then((response) => {
          let com = JSON.parse(response.data);
          this.allComments = com;
        })
        .catch((error) => {
          console.log(error);
        });
    },
    sendCom(pId) {
      this.dataCom.userId = this.userId;
      this.dataComS = JSON.stringify(this.dataCom);
      console.log(this.dataComS);
      axios
        .post(
          "http://localhost:3000/api/posts/" + pId + "/comments",
          this.dataComS,
          {
            headers: {
              "Content-Type": "application/json",
              Authorization: "Bearer " + localStorage.token,
            },
          }
        )
        .then((response) => {
          let rep = JSON.parse(response.data);
          console.log(rep.message);
          this.dataCom.content = "";
          this.dataCom.userId = "";
          this.commenterPost = false;
          this.afficheCom(pId);
        })
        .catch((error) => {
          console.log(error);
          this.message = error;
          this.msg = true;
        });
    },
    deletePost(pId) {
      axios
        .delete("http://localhost:3000/api/posts/" + pId, {
          headers: { Authorization: "Bearer " + localStorage.token },
        })
        .then((response) => {
          let rep = JSON.parse(response.data);
          console.log(rep.message);
          window.location.assign("http://localhost:8080/Accueil");
        })
        .catch((error) => {
          console.log(error);
        });
    },
    deleteCom(cId) {
      axios
        .delete("http://localhost:3000/api/posts/comments/" + cId, {
          headers: { Authorization: "Bearer " + localStorage.token },
        })
        .then((response) => {
          let rep = JSON.parse(response.data);
          console.log(rep.message);
          window.location.assign("http://localhost:8080/Accueil");
        })
        .catch((error) => {
          console.log(error);
        });
    },
    goDialogUpPost(postTitle, postContent, postId) {
      this.dataPost.title = postTitle;
      this.dataPost.content = postContent;
      this.dataPost.id = postId;
      this.dialogUpPost = true;
    },
    updatePost() {
      this.dataPost.userId = localStorage.userId;
      this.dataPostS = JSON.stringify(this.dataPost);
      axios
        .put(
          "http://localhost:3000/api/posts/" + this.dataPost.id,
          this.dataPostS,
          {
            headers: {
              "Content-Type": "application/json",
              Authorization: "Bearer " + localStorage.token,
            },
          }
        )
        .then((response) => {
          let rep = JSON.parse(response.data);
          console.log(rep.message);
          this.dataPost.title = "";
          this.dataPost.content = "";
          this.dataPost.userId = "";
          this.dataPost.id = "";
          this.dialogUpPost = false;
          window.location.assign("http://localhost:8080/Accueil");
        })
        .catch((error) => {
          console.log(error);
        });
    },
    goDialogUpCom(comContent, comId) {
      this.dataCom.id = comId;
      this.dataCom.content = comContent;
      this.dialogUpCom = true;
    },
    updateCom() {
      this.dataCom.userId = localStorage.userId;
      this.dataComS = JSON.stringify(this.dataComS);
      axios
        .put(
          "http://localhost:3000/api/posts/comments/" + this.dataCom.id,
          this.dataComS,
          {
            headers: {
              "Content-Type": "application/json",
              Authorization: "Bearer " + localStorage.token,
            },
          }
        )
        .then((response) => {
          let rep = JSON.parse(response.data);
          console.log(rep.message);
          this.dataCom.content = "";
          this.dataCom.userId = "";
          this.commenterPost = false;
          this.dialogUpCom = false;
          window.location.assign("http://localhost:8080/Accueil");
        })
        .catch((error) => {
          console.log(error);
        });
    },
    afficheForm() {
      this.$router.push("/Accueil/forum/Post");
    },
    afficheCommenterPost() {
      this.commenterPost = true;
    },
  },
  components: {
    "top-header": TopHeader,
  },
  mounted() {
    this.userId = localStorage.userId;
    axios
      .get("http://localhost:3000/api/posts", {
        headers: { Authorization: "Bearer " + localStorage.token },
      })
      .then((response) => {
        let posts = JSON.parse(response.data);
        this.allPosts = posts;
        console.log(this.allPosts);
      })
      .catch((error) => {
        console.log(error);
      });
  },
};
</script>
<style lang="scss">
#forum {
  background-color: #e8e8e8;
}
h1 {
  text-align: center;
}
.imgPost {
  max-width: 300px;
}
.forum {
  &__comments {
    &--ind {
      position: relative;
    }
  }
}
.forum__post {
  justify-content: center;
}
</style>
